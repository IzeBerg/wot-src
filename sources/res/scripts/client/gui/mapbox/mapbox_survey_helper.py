from enum import Enum
import logging, json, typing
from gui.impl.gen import R
from gui.impl.gen.view_models.views.lobby.mapbox.map_box_question_model import QuestionType
from gui.shared.utils.functions import replaceHyphenToUnderscore
from helpers import dependency
from skeletons.gui.game_control import IMapboxController
from shared_utils import findFirst, first
_logger = logging.getLogger(__name__)
_STR_PATH = R.strings.mapbox.survey

class QuantifierTypes(Enum):
    SINGLE = 'single'
    MULTIPLE = 'multiple'

    @classmethod
    def hasValue(cls, value):
        return value in cls._value2member_map_


class Condition(object):
    __slots__ = ('__requiredQuestionId', '__requiredAnswers', '__quantifier', '__isRequiredAnswer')
    __mapboxCtrl = dependency.descriptor(IMapboxController)

    def __init__(self, requiredQuestionId, requiredAnswers, quantifier, isRequired=False):
        self.__requiredQuestionId = requiredQuestionId
        self.__requiredAnswers = requiredAnswers
        self.__quantifier = quantifier
        self.__isRequiredAnswer = isRequired

    def isValid(self):
        surveyManager = self.__mapboxCtrl.surveyManager
        selectedAnswers = surveyManager.getSelectedAnswers(self.__requiredQuestionId)
        if not selectedAnswers and self.__isRequiredAnswer:
            return False
        if self.__quantifier == QuantifierTypes.MULTIPLE.value:
            return len(selectedAnswers) > 1 and set(selectedAnswers).issubset(set(self.__requiredAnswers))
        return len(set(selectedAnswers).intersection(set(self.__requiredAnswers))) == 1

    def clear(self):
        self.__requiredAnswers = []


class IQuestion(object):

    def getQuestionId(self):
        raise NotImplementedError

    def getQuestionType(self):
        raise NotImplementedError

    def isRequired(self):
        raise NotImplementedError

    def isReadyToShow(self):
        raise NotImplementedError

    def getLinkedQuestionId(self):
        pass

    def isMultipleChoice(self):
        pass

    def clear(self):
        pass

    def convertAnswers(self, answers, optionId):
        pass

    def validateAnswers(self, answers, previousAnswers):
        pass


class Question(IQuestion):
    __slots__ = ('__questionId', '__isMultiple', '__isRequired', '__condition', '__answers',
                 '__guiParameters', '__linkedParameters')
    _mapboxCtrl = dependency.descriptor(IMapboxController)

    def __init__(self, *args, **kwargs):
        self.__questionId = kwargs.get('questionId', None)
        self.__isRequired = kwargs.get('isRequired', False)
        self.__isMultiple = kwargs.get('isMultiple', False)
        self.__condition = kwargs.get('condition')
        self.__answers = kwargs.get('answers')
        self.__guiParameters = kwargs.get('guiParameters')
        self.__linkedParameters = kwargs.get('linkedParameters')
        return

    def getQuestionId(self):
        return self.__questionId

    def isRequired(self):
        return self.__isRequired

    def isMultipleChoice(self):
        return self.__isMultiple

    def getImage(self):
        if self.__guiParameters.useMapId:
            return '%s_%s' % (self.__guiParameters.image, self._mapboxCtrl.surveyManager.getMapId())
        else:
            if self.__guiParameters.useLinkedParams:
                sourceQuestionId = self.getLinkedQuestionId()
                if sourceQuestionId:
                    choice = first(self._mapboxCtrl.surveyManager.getSelectedAnswers(sourceQuestionId))
                    return '%s_%s' % (self.__guiParameters.image, replaceHyphenToUnderscore(choice))
            if self.__guiParameters is not None:
                return self.__guiParameters.image
            return ''

    def isUsingIcons(self):
        if self.__guiParameters is not None:
            return self.__guiParameters.showIcons
        else:
            return False

    def getTitleParameters(self):
        if not self.__linkedParameters:
            return []
        sourceQuestionId = self.__linkedParameters.fromQuestion
        answerResIds = [ _STR_PATH.response.num(('_').join((sourceQuestionId, replaceHyphenToUnderscore(answer))))() for answer in self.__linkedParameters.answers if answer in self._mapboxCtrl.surveyManager.getSelectedAnswers(sourceQuestionId)
                       ]
        return [ resId for resId in answerResIds if resId != R.invalid() ]

    def getLinkedQuestionId(self):
        if self.__linkedParameters:
            return self.__linkedParameters.fromQuestion
        else:
            return

    def getAnswers(self):
        if self.__answers is not None:
            return self.__answers.variants
        else:
            return []

    def isReadyToShow(self):
        return self.__condition is None or self.__condition.isValid()

    def convertAnswers(self, answers, optionId):
        if len(answers) > 1:
            _logger.error('Incorrect answers for the question with questionId=%s', self.__questionId)
            return []
        if answers:
            return answers[0].get('choices', [])
        return []

    def validateAnswers(self, answers, oldAnswers):
        groupsAnswers = self.__answers.responseGroups if self.__answers is not None else None
        if groupsAnswers is None:
            return answers
        else:
            newChoices = first(answers, {}).get('choices', [])
            if any([ set(newChoices).issubset(group) for group in groupsAnswers ]):
                return answers
            newChoice = set(newChoices) - set(first(oldAnswers, {}).get('choices', []))
            requiredGroup = findFirst(lambda group: newChoice.issubset(set(group)), groupsAnswers, [])
            answers[0]['choices'] = set(requiredGroup).intersection(newChoices)
            return answers

    def clear(self):
        if self.__condition is not None:
            self.__condition.clear()
            self.__condition = None
        self.__guiParameters = None
        self.__linkedParameters = None
        self.__answers = None
        return


class _TableQuestion(Question):
    __slots__ = ('__options', )

    def __init__(self, *args, **kwargs):
        super(_TableQuestion, self).__init__(*args, **kwargs)
        self.__options = kwargs.get('options')

    def getQuestionType(self):
        return QuestionType.TABLE

    def convertAnswers(self, answers, optionId):
        answer = findFirst(lambda answer: answer.get('optionId') == optionId, answers)
        if answer is not None:
            return answer.get('choices', [])
        else:
            return []

    def getOptions(self):
        if self.__options is None:
            return []
        else:
            if self.__options.fromQuestion is None:
                return self.__options.answers
            return [ option for option in self.__options.answers if option in self._mapboxCtrl.surveyManager.getSelectedAnswers(self.__options.fromQuestion)
                   ]

    def validateAnswers(self, answers, oldAnswers):
        _logger.debug('Unsupported operation for a table question')
        return answers

    def clear(self):
        self.__options = None
        super(_TableQuestion, self).clear()
        return


class _InteractiveMapQuestion(Question):
    __slots__ = ()

    def getQuestionType(self):
        return QuestionType.INTERACTIVE_MAP

    def convertAnswers(self, answers, optionId):
        if not answers:
            return []
        choices = answers[0].get('choices', [])
        return [ json.dumps(item) for item in choices ]

    def validateAnswers(self, answers, oldAnswers):
        _logger.debug('Unsupported operation for a question with the interactive map')
        return answers


class _VehicleQuestion(Question):
    __slots__ = ()

    def getQuestionType(self):
        return QuestionType.VEHICLE

    def convertAnswers(self, answers, optionId):
        if answers:
            return first(answers, {}).get('choices', [])
        return []


class _ImageQuestion(Question):
    __slots__ = ()

    def getQuestionType(self):
        return QuestionType.IMAGE


class _TextQuestion(Question):
    __slots__ = ()

    def getQuestionType(self):
        return QuestionType.TEXT

    def validateAnswers(self, answers, oldAnswers):
        _logger.debug('Unsupported operation for a text question')
        return answers


class AlternativeQuestion(IQuestion):
    __slots__ = ('__questionId', '__alternatives')

    def __init__(self, *args, **kwargs):
        self.__questionId = kwargs.get('questionId', None)
        self.__alternatives = kwargs.get('alternatives', [])
        return

    def getQuestionType(self):
        return QuestionType.ALTERNATIVE

    def getQuestionId(self):
        return self.__questionId

    def isRequired(self):
        return all(q.isRequired() for q in self.__alternatives)

    def selectAlternative(self):
        question = findFirst(lambda q: q.isReadyToShow(), self.__alternatives)
        return question

    def getAlternative(self, questionId):
        return findFirst(lambda q: q.getQuestionId() == questionId, self.__alternatives)

    def getLinkedQuestionId(self):
        for q in self.__alternatives:
            if q.getLinkedQuestionId():
                return q.getLinkedQuestionId()

        return

    def getAlternatives(self):
        return self.__alternatives

    def isReadyToShow(self):
        return any(q.isReadyToShow() for q in self.__alternatives)

    def clear(self):
        for question in self.__alternatives:
            question.clear()

        self.__alternatives = []


_SUPPORTED_QUESTION_TYPES = {QuestionType.IMAGE.value: _ImageQuestion, 
   QuestionType.VEHICLE.value: _VehicleQuestion, 
   QuestionType.TABLE.value: _TableQuestion, 
   QuestionType.INTERACTIVE_MAP.value: _InteractiveMapQuestion, 
   QuestionType.TEXT.value: _TextQuestion, 
   QuestionType.ALTERNATIVE.value: AlternativeQuestion}

def getQuestionClass(questionType):
    return _SUPPORTED_QUESTION_TYPES.get(questionType)