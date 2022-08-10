from typing import Tuple, Any
import ResMgr
from constants import IS_EDITOR
from items import decodeEnum
from items.components.c11n_constants import ApplyArea, Options
from items.utils import getEditorOnlySection
from serialization.definitions import FieldFlags, FieldTypes
from serialization.exceptions import SerializationException
from serialization.serializable_component import SerializableComponent
__all__ = ('ComponentXmlDeserializer', )

class ComponentXmlDeserializer(object):
    __slots__ = ('customTypes', )

    def __init__(self, customTypes):
        self.customTypes = customTypes
        super(ComponentXmlDeserializer, self).__init__()

    def decode(self, itemType, xmlCtx, section):
        obj = self.__decodeCustomType(itemType, xmlCtx, section)
        return obj

    def __decodeCustomType--- This code section failed: ---

 L.  32         0  LOAD_FAST             0  'self'
                3  LOAD_ATTR             0  'customTypes'
                6  LOAD_FAST             1  'customType'
                9  BINARY_SUBSCR    
               10  STORE_FAST            4  'cls'

 L.  33        13  LOAD_FAST             4  'cls'
               16  CALL_FUNCTION_0       0  None
               19  STORE_FAST            5  'instance'

 L.  34        22  SETUP_LOOP          619  'to 644'
               25  LOAD_FAST             4  'cls'
               28  LOAD_ATTR             1  'fields'
               31  LOAD_ATTR             2  'iteritems'
               34  CALL_FUNCTION_0       0  None
               37  GET_ITER         
               38  FOR_ITER            602  'to 643'
               41  UNPACK_SEQUENCE_2     2 
               44  STORE_FAST            6  'fname'
               47  STORE_FAST            7  'finfo'

 L.  35        50  LOAD_FAST             7  'finfo'
               53  LOAD_ATTR             3  'flags'
               56  LOAD_GLOBAL           4  'FieldFlags'
               59  LOAD_ATTR             5  'NON_XML'
               62  BINARY_AND       
               63  POP_JUMP_IF_FALSE    72  'to 72'

 L.  36        66  CONTINUE             38  'to 38'
               69  JUMP_FORWARD          0  'to 72'
             72_0  COME_FROM            69  '69'

 L.  38        72  LOAD_FAST             3  'section'
               75  LOAD_ATTR             6  'has_key'
               78  LOAD_FAST             6  'fname'
               81  CALL_FUNCTION_1       1  None
               84  POP_JUMP_IF_TRUE    175  'to 175'

 L.  39        87  LOAD_GLOBAL           7  'IS_EDITOR'
               90  POP_JUMP_IF_FALSE    38  'to 38'
               93  LOAD_FAST             7  'finfo'
               96  LOAD_ATTR             3  'flags'
               99  LOAD_GLOBAL           4  'FieldFlags'
              102  LOAD_ATTR             8  'SAVE_AS_EDITOR_ONLY'
              105  BINARY_AND       
            106_0  COME_FROM            90  '90'
              106  POP_JUMP_IF_FALSE    38  'to 38'

 L.  40       109  LOAD_GLOBAL           9  'getEditorOnlySection'
              112  LOAD_FAST             3  'section'
              115  CALL_FUNCTION_1       1  None
              118  STORE_FAST            8  'editorOnlySection'

 L.  41       121  LOAD_FAST             8  'editorOnlySection'
              124  LOAD_CONST               None
              127  COMPARE_OP            9  is-not
              130  POP_JUMP_IF_FALSE    38  'to 38'

 L.  42       133  LOAD_FAST             8  'editorOnlySection'
              136  LOAD_ATTR             6  'has_key'
              139  LOAD_FAST             6  'fname'
              142  CALL_FUNCTION_1       1  None
            145_0  COME_FROM           130  '130'
              145  POP_JUMP_IF_FALSE    38  'to 38'

 L.  43       148  LOAD_FAST             8  'editorOnlySection'
              151  STORE_FAST            3  'section'
              154  JUMP_ABSOLUTE       166  'to 166'

 L.  45       157  CONTINUE             38  'to 38'
              160  JUMP_ABSOLUTE       172  'to 172'

 L.  47       163  CONTINUE             38  'to 38'
              166  JUMP_ABSOLUTE       175  'to 175'

 L.  49       169  CONTINUE             38  'to 38'
              172  JUMP_FORWARD          0  'to 175'
            175_0  COME_FROM           172  '172'

 L.  51       175  LOAD_FAST             7  'finfo'
              178  LOAD_ATTR            11  'type'
              181  STORE_FAST            9  'ftype'

 L.  52       184  LOAD_FAST             9  'ftype'
              187  LOAD_GLOBAL          12  'FieldTypes'
              190  LOAD_ATTR            13  'VARINT'
              193  COMPARE_OP            2  ==
              196  POP_JUMP_IF_FALSE   217  'to 217'

 L.  53       199  LOAD_FAST             3  'section'
              202  LOAD_ATTR            14  'readInt'
              205  LOAD_FAST             6  'fname'
              208  CALL_FUNCTION_1       1  None
              211  STORE_FAST           10  'value'
              214  JUMP_FORWARD        335  'to 552'

 L.  54       217  LOAD_FAST             9  'ftype'
              220  LOAD_GLOBAL          12  'FieldTypes'
              223  LOAD_ATTR            15  'FLOAT'
              226  COMPARE_OP            2  ==
              229  POP_JUMP_IF_FALSE   250  'to 250'

 L.  55       232  LOAD_FAST             3  'section'
              235  LOAD_ATTR            16  'readFloat'
              238  LOAD_FAST             6  'fname'
              241  CALL_FUNCTION_1       1  None
              244  STORE_FAST           10  'value'
              247  JUMP_FORWARD        302  'to 552'

 L.  56       250  LOAD_FAST             9  'ftype'
              253  LOAD_GLOBAL          12  'FieldTypes'
              256  LOAD_ATTR            17  'APPLY_AREA_ENUM'
              259  COMPARE_OP            2  ==
              262  POP_JUMP_IF_FALSE   295  'to 295'

 L.  57       265  LOAD_FAST             0  'self'
              268  LOAD_ATTR            18  '__decodeEnum'
              271  LOAD_FAST             3  'section'
              274  LOAD_ATTR            19  'readString'
              277  LOAD_FAST             6  'fname'
              280  CALL_FUNCTION_1       1  None
              283  LOAD_GLOBAL          20  'ApplyArea'
              286  CALL_FUNCTION_2       2  None
              289  STORE_FAST           10  'value'
              292  JUMP_FORWARD        257  'to 552'

 L.  58       295  LOAD_FAST             9  'ftype'
              298  LOAD_GLOBAL          12  'FieldTypes'
              301  LOAD_ATTR            21  'TAGS'
              304  COMPARE_OP            2  ==
              307  POP_JUMP_IF_FALSE   340  'to 340'

 L.  59       310  LOAD_GLOBAL          22  'tuple'
              313  LOAD_FAST             3  'section'
              316  LOAD_ATTR            19  'readString'
              319  LOAD_FAST             6  'fname'
              322  CALL_FUNCTION_1       1  None
              325  LOAD_ATTR            23  'split'
              328  CALL_FUNCTION_0       0  None
              331  CALL_FUNCTION_1       1  None
              334  STORE_FAST           10  'value'
              337  JUMP_FORWARD        212  'to 552'

 L.  60       340  LOAD_FAST             9  'ftype'
              343  LOAD_GLOBAL          12  'FieldTypes'
              346  LOAD_ATTR            24  'STRING'
              349  COMPARE_OP            2  ==
              352  POP_JUMP_IF_FALSE   373  'to 373'

 L.  61       355  LOAD_FAST             3  'section'
              358  LOAD_ATTR            19  'readString'
              361  LOAD_FAST             6  'fname'
              364  CALL_FUNCTION_1       1  None
              367  STORE_FAST           10  'value'
              370  JUMP_FORWARD        179  'to 552'

 L.  62       373  LOAD_FAST             9  'ftype'
              376  LOAD_GLOBAL          12  'FieldTypes'
              379  LOAD_ATTR            25  'OPTIONS_ENUM'
              382  COMPARE_OP            2  ==
              385  POP_JUMP_IF_FALSE   418  'to 418'

 L.  63       388  LOAD_FAST             0  'self'
              391  LOAD_ATTR            18  '__decodeEnum'
              394  LOAD_FAST             3  'section'
              397  LOAD_ATTR            19  'readString'
              400  LOAD_FAST             6  'fname'
              403  CALL_FUNCTION_1       1  None
              406  LOAD_GLOBAL          26  'Options'
              409  CALL_FUNCTION_2       2  None
              412  STORE_FAST           10  'value'
              415  JUMP_FORWARD        134  'to 552'

 L.  64       418  LOAD_FAST             9  'ftype'
              421  LOAD_GLOBAL          12  'FieldTypes'
              424  LOAD_ATTR            27  'TYPED_ARRAY'
              427  BINARY_AND       
              428  POP_JUMP_IF_FALSE   478  'to 478'

 L.  65       431  LOAD_FAST             9  'ftype'
              434  LOAD_GLOBAL          12  'FieldTypes'
              437  LOAD_ATTR            27  'TYPED_ARRAY'
              440  BINARY_XOR       
              441  STORE_FAST           11  'itemType'

 L.  66       444  LOAD_FAST             0  'self'
              447  LOAD_ATTR            28  '__decodeArray'
              450  LOAD_FAST            11  'itemType'
              453  LOAD_FAST             2  'ctx'
              456  LOAD_FAST             6  'fname'
              459  BUILD_TUPLE_2         2 
              462  LOAD_FAST             3  'section'
              465  LOAD_FAST             6  'fname'
              468  BINARY_SUBSCR    
              469  CALL_FUNCTION_3       3  None
              472  STORE_FAST           10  'value'
              475  JUMP_FORWARD         74  'to 552'

 L.  67       478  LOAD_FAST             9  'ftype'
              481  LOAD_GLOBAL          12  'FieldTypes'
              484  LOAD_ATTR            29  'CUSTOM_TYPE_OFFSET'
              487  COMPARE_OP            5  >=
              490  POP_JUMP_IF_FALSE   540  'to 540'

 L.  68       493  LOAD_FAST             9  'ftype'
              496  LOAD_GLOBAL          12  'FieldTypes'
              499  LOAD_ATTR            29  'CUSTOM_TYPE_OFFSET'
              502  BINARY_DIVIDE    
              503  STORE_FAST            9  'ftype'

 L.  69       506  LOAD_FAST             0  'self'
              509  LOAD_ATTR            30  '__decodeCustomType'
              512  LOAD_FAST             9  'ftype'
              515  LOAD_FAST             2  'ctx'
              518  LOAD_FAST             6  'fname'
              521  BUILD_TUPLE_2         2 
              524  LOAD_FAST             3  'section'
              527  LOAD_FAST             6  'fname'
              530  BINARY_SUBSCR    
              531  CALL_FUNCTION_3       3  None
              534  STORE_FAST           10  'value'
              537  JUMP_FORWARD         12  'to 552'

 L.  71       540  LOAD_GLOBAL          31  'SerializationException'
              543  LOAD_CONST               'Unsupported item type'
              546  CALL_FUNCTION_1       1  None
              549  RAISE_VARARGS_1       1  None
            552_0  COME_FROM           537  '537'
            552_1  COME_FROM           475  '475'
            552_2  COME_FROM           415  '415'
            552_3  COME_FROM           370  '370'
            552_4  COME_FROM           337  '337'
            552_5  COME_FROM           292  '292'
            552_6  COME_FROM           247  '247'
            552_7  COME_FROM           214  '214'

 L.  72       552  LOAD_FAST             7  'finfo'
              555  LOAD_ATTR             3  'flags'
              558  LOAD_GLOBAL           4  'FieldFlags'
              561  LOAD_ATTR            32  'DEPRECATED'
              564  BINARY_AND       
              565  UNARY_NOT        
              566  POP_JUMP_IF_TRUE    584  'to 584'
              569  LOAD_GLOBAL          33  'hasattr'
              572  LOAD_FAST             5  'instance'
              575  LOAD_FAST             6  'fname'
              578  CALL_FUNCTION_2       2  None
            581_0  COME_FROM           566  '566'
              581  POP_JUMP_IF_FALSE   603  'to 603'

 L.  73       584  LOAD_GLOBAL          34  'setattr'
              587  LOAD_FAST             5  'instance'
              590  LOAD_FAST             6  'fname'
              593  LOAD_FAST            10  'value'
              596  CALL_FUNCTION_3       3  None
              599  POP_TOP          
              600  JUMP_FORWARD          0  'to 603'
            603_0  COME_FROM           600  '600'

 L.  75       603  LOAD_GLOBAL           7  'IS_EDITOR'
              606  POP_JUMP_IF_FALSE    38  'to 38'
              609  LOAD_FAST             7  'finfo'
              612  LOAD_ATTR             3  'flags'
              615  LOAD_GLOBAL           4  'FieldFlags'
              618  LOAD_ATTR             8  'SAVE_AS_EDITOR_ONLY'
              621  BINARY_AND       
            622_0  COME_FROM           606  '606'
              622  POP_JUMP_IF_FALSE    38  'to 38'

 L.  76       625  LOAD_FAST             3  'section'
              628  LOAD_ATTR            35  'parentSection'
              631  CALL_FUNCTION_0       0  None
              634  STORE_FAST            3  'section'
              637  JUMP_BACK            38  'to 38'
              640  JUMP_BACK            38  'to 38'
              643  POP_BLOCK        
            644_0  COME_FROM            22  '22'

 L.  77       644  LOAD_FAST             5  'instance'
              647  RETURN_VALUE     

Parse error at or near `JUMP_ABSOLUTE' instruction at offset 166

    def __decodeArray(self, itemType, ctx, section):
        result = []
        for i, (iname, isection) in enumerate(section.items()):
            if itemType == FieldTypes.VARINT:
                result.append(isection.asInt)
            elif itemType == FieldTypes.FLOAT:
                result.append(isection.asFloat)
            elif itemType >= FieldTypes.CUSTOM_TYPE_OFFSET:
                customType = itemType / FieldTypes.CUSTOM_TYPE_OFFSET
                ictx = (ctx, ('{0} {1}').format(iname, isection))
                result.append(self.__decodeCustomType(customType, ictx, isection))
            else:
                raise SerializationException('Unsupported item type')

        return result

    def __decodeEnum(self, value, enum):
        return decodeEnum(value, enum)[0]# Decompile failed :(