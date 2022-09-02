from collections import namedtuple
import logging
from gui.mapbox.mapbox_survey_helper import Condition, QuantifierTypes, AlternativeOneManyQuestion, AlternativeQuestion, getQuestionClass
import resource_helper
from soft_exception import SoftException
_logger = logging.getLogger(__name__)
_SURVEYS_XML_PATH = 'gui/surveys.xml'
_SURVEYS = None
_GuiParams = namedtuple('_GuiParams', ('image', 'showIcons', 'useMapId', 'useLinkedParams'))
_AdditionalParam = namedtuple('_AdditionalParam', ('fromQuestion', 'answers'))
_Responses = namedtuple('_Responses', ('variants', 'responseGroups'))

def _readCondition(section, isRequired):
    if not section.has_key('condition'):
        return None
    else:
        subSection = section['condition']
        requiredQuestionId = subSection['requiredQuestionId'].asString
        requiredAnswers = [ answerId for answerId in subSection['requiredAnswers'].asString.split(' ') ]
        if not requiredAnswers:
            raise SoftException('Unfilled required answers for the condition')
        innerSubsection = subSection['requiredAnswers']
        if not innerSubsection.keys():
            quantifier = QuantifierTypes.SINGLE.value if 1 else innerSubsection['quantifier'].asString
            raise (QuantifierTypes.hasValue(quantifier) or SoftException)('Unsupported condition type for the mapbox survey')
        return Condition(requiredQuestionId, requiredAnswers, quantifier, isRequired)


def _readUseAnswersSection(section):
    if section.has_key('useAnswers'):
        answers = section.readString('useAnswers').split(' ')
        innerSubsection = section['useAnswers']
        if not innerSubsection.has_key('questionID'):
            raise SoftException('Invalid useAnswers section for the mapbox survey')
        questionId = innerSubsection['questionID'].asString
        return _AdditionalParam(questionId, answers)
    else:
        return


def _readLinkedParameters(section):
    if not section.has_key('linkedParameters'):
        return None
    else:
        return _readUseAnswersSection(section['linkedParameters'])


def _readGuiParameters(section):
    return _GuiParams(image=section.readString('image'), showIcons=section.readBool('showIcons'), useMapId=section.readBool('useMapId'), useLinkedParams=section.readBool('useLinkedParams'))


def _readOptions(section):
    if not section.has_key('options'):
        return
    else:
        optionsSection = section['options']
        result = _readUseAnswersSection(optionsSection)
        if result is not None:
            return result
        return _AdditionalParam(fromQuestion=None, answers=optionsSection.asString.split(' '))


def _readResponses(section):
    variants = section.readString('responses')
    if section.has_key('responseGroups'):
        groups = [ group.asString.split(' ') for group in section['responseGroups'].values() ]
    else:
        groups = None
    return _Responses(variants.split(' ') if variants else [], groups)


def _readQuestion(questionSection, questionTypes):
    qId = questionSection['questionId'].asString
    isRequired = questionSection['isRequired'].asBool
    isMultiple = questionSection['isMultiple'].asBool
    condition = _readCondition(questionSection, isRequired)
    guiParameters = _readGuiParameters(questionSection)
    responses = _readResponses(questionSection)
    options = _readOptions(questionSection)
    linkedParameters = _readLinkedParameters(questionSection)
    qType = questionSection['questionType'].asString
    if qType not in questionTypes:
        raise SoftException('Incorrect question type "%s" in the survey settings' % qType)
    clz = getQuestionClass(qType)
    return clz(questionId=qId, questionType=qType, isMultiple=isMultiple, isRequired=isRequired, condition=condition, answers=responses, options=options, linkedParameters=linkedParameters, guiParameters=guiParameters)


def _readAlternativeQuestion(questionSection, questionTypes, qId):
    alternativeQuestions = [ _readQuestion(variant, questionTypes) for variant in questionSection['alternatives'].values()
                           ]
    isSynchronizedAnswers = questionSection.readBool('synchronizeAnswers')
    clz = AlternativeOneManyQuestion if isSynchronizedAnswers else AlternativeQuestion
    return clz(questionId=qId, alternatives=alternativeQuestions, isSynchronizedAnswers=isSynchronizedAnswers)


def _readSurveys():
    result = {}
    ctx, root = resource_helper.getRoot(_SURVEYS_XML_PATH)
    for _, serveySection in resource_helper.getIterator(ctx, root['surveys']):
        bonusType = serveySection['bonusType'].asInt
        if not bonusType:
            raise SoftException('Incorrect bonusType for a survey')
        questionTypes = frozenset(serveySection['questionTypes'].asString.split(' '))
        questions = []
        for questionSection in serveySection['questions'].values():
            if questionSection.has_key('alternatives'):
                qId = questionSection['questionId'].asString
                question = _readAlternativeQuestion(questionSection, questionTypes, qId)
            else:
                question = _readQuestion(questionSection, questionTypes)
            questions.append(question)

        result[bonusType] = questions

    resource_helper.purgeResource(_SURVEYS_XML_PATH)
    return result


def getSurvey(bonusType):
    global _SURVEYS
    if _SURVEYS is None:
        _SURVEYS = _readSurveys()
    return _SURVEYS.get(bonusType)