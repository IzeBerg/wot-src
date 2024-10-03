package net.wg.gui.lobby.techtree.data.vo
{
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.generated.NODE_STATE_FLAGS;
   import net.wg.gui.components.controls.VO.ItemPriceVO;
   import net.wg.gui.lobby.techtree.interfaces.IValueObject;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.utils.ILocale;
   
   public class NodeData implements IValueObject
   {
      
      private static var _displayInfoClass:Class = null;
      
      public static const UNLOCK_PROPS_FIELD:String = "unlockProps";
      
      public static const VEH_COMPARE_TREE_NODE_DATA:String = "vehCompareTreeNodeData";
      
      private static const BUY_PRICE_FIELD:String = "buyPrice";
      
      private static const EXTRA_INFO_FIELD:String = "extraInfo";
      
      private static const BLUEPRINT_LABEL_FIELD:String = "blueprintLabel";
      
      private static const BLUEPRINT_PROGRESS_FIELD:String = "blueprintProgress";
      
      private static const BLUEPRINT_CAN_CONVERT_FIELD:String = "blueprintCanConvert";
      
      private static const EARNED_XP_FIELD:String = "earnedXP";
      
      private static const FROM_ARRAY:String = "NodeData.fromArray";
      
      private static const IS_NATION_CHANGE_AVAILABLE:String = "isNationChangeAvailable";
      
      private static const IS_TOP_ACTION_NODE:String = "isTopActionNode";
      
      private static const ACTION_MESSAGE:String = "actionMessage";
      
      private static const IS_FIRST_TIME_EARLY_ACCESS_SHOW:String = "isFirstTimeEarlyAccessShow";
      
      private static const IS_EARLY_ACCESS_LOCKED:String = "isEarlyAccessLocked";
      
      private static const IS_EARLY_ACCESS_PAUSED:String = "isEarlyAccessPaused";
      
      private static const EARLY_ACCESS_CURRENT_TOKENS:String = "earlyAccessCurrentTokens";
      
      private static const EARLY_ACCESS_TOTAL_TOKENS:String = "earlyAccessTotalTokens";
      
      private static const IS_EARLY_ACCESS_CAN_BUY:String = "isEarlyAccessCanBuy";
       
      
      public var id:uint = 0;
      
      public var nameString:String = "";
      
      public var level:int = -1;
      
      public var state:uint = 0;
      
      public var iconPath:String = "";
      
      public var smallIconPath:String = "";
      
      public var shopIconPath:String = "";
      
      public var extraInfo:String = null;
      
      public var primaryClassName:String = "";
      
      public var displayInfo:IValueObject = null;
      
      public var dataIsReady:Boolean = false;
      
      public var earnedXP:Number = 0;
      
      public var unlockProps:UnlockProps = null;
      
      public var isTopActionNode:Boolean = false;
      
      public var actionMessage:String = "";
      
      public var isFirstTimeEarlyAccessShow:Boolean = false;
      
      public var isEarlyAccessLocked:Boolean = false;
      
      public var isEarlyAccessPaused:Boolean = false;
      
      public var isEarlyAccessCanBuy:Boolean = false;
      
      public var earlyAccessCurrentTokens:int = 0;
      
      public var earlyAccessTotalTokens:int = 0;
      
      private var _blueprintLabel:String = "";
      
      private var _blueprintProgress:Number = 0;
      
      private var _blueprintCanConvert:Boolean = false;
      
      private var _buyPrice:ItemPriceVO = null;
      
      private var _vehCompareTreeNodeVO:VehCompareEntrypointTreeNodeVO = null;
      
      private var _isNationChangeAvailable:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      public function NodeData()
      {
         super();
      }
      
      public static function setDisplayInfoClass(param1:Class) : void
      {
         _displayInfoClass = param1;
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      public function fromArray(param1:Array, param2:ILocale) : void
      {
         throw new AbstractException(FROM_ARRAY + Errors.ABSTRACT_INVOKE);
      }
      
      public function fromObject(param1:Object, param2:ILocale) : void
      {
         var _loc3_:String = null;
         if(param1 == null)
         {
            return;
         }
         if(!isNaN(param1.id))
         {
            this.id = param1.id;
         }
         if(param1.nameString != null)
         {
            this.nameString = param1.nameString;
         }
         if(param1.primaryClass != null && param1.primaryClass.name != null)
         {
            this.primaryClassName = param1.primaryClass.name;
         }
         if(param1.level != null)
         {
            this.level = param1.level;
         }
         if(!isNaN(param1.state))
         {
            this.state = param1.state;
         }
         this.clearUnlockProps();
         this.unlockProps = new UnlockProps();
         if(param1.unlockProps != null)
         {
            this.unlockProps.fromArray(param1.unlockProps,param2);
         }
         if(param1.hasOwnProperty(EXTRA_INFO_FIELD))
         {
            _loc3_ = param1[EXTRA_INFO_FIELD];
            if(_loc3_)
            {
               this.extraInfo = _loc3_;
            }
         }
         if(param1.hasOwnProperty(VEH_COMPARE_TREE_NODE_DATA))
         {
            this.clearVehCompareTreeNodeVO();
            this._vehCompareTreeNodeVO = new VehCompareEntrypointTreeNodeVO(param1[VEH_COMPARE_TREE_NODE_DATA]);
         }
         if(param1.hasOwnProperty(BLUEPRINT_LABEL_FIELD))
         {
            this._blueprintLabel = param1[BLUEPRINT_LABEL_FIELD];
         }
         if(param1.hasOwnProperty(BLUEPRINT_PROGRESS_FIELD))
         {
            this._blueprintProgress = param1[BLUEPRINT_PROGRESS_FIELD];
         }
         if(param1.hasOwnProperty(BLUEPRINT_CAN_CONVERT_FIELD))
         {
            this._blueprintCanConvert = param1[BLUEPRINT_CAN_CONVERT_FIELD];
         }
         if(param1.iconPath != null)
         {
            this.iconPath = param1.iconPath;
         }
         if(param1.smallIconPath != null)
         {
            this.smallIconPath = param1.smallIconPath;
         }
         if(param1.shopIconPath != null)
         {
            this.shopIconPath = param1.shopIconPath;
         }
         if(_displayInfoClass != null)
         {
            this.clearDisplayInfo();
            this.displayInfo = new _displayInfoClass();
         }
         if(param1.displayInfo != null && this.displayInfo != null)
         {
            this.displayInfo.fromObject(param1.displayInfo,param2);
         }
         if(param1[BUY_PRICE_FIELD])
         {
            this.clearBuyPrice();
            this._buyPrice = new ItemPriceVO(param1[BUY_PRICE_FIELD][0]);
         }
         if(param1.hasOwnProperty(EARNED_XP_FIELD))
         {
            this.earnedXP = param1[EARNED_XP_FIELD];
         }
         if(param1.hasOwnProperty(IS_NATION_CHANGE_AVAILABLE))
         {
            this._isNationChangeAvailable = param1[IS_NATION_CHANGE_AVAILABLE];
         }
         if(param1.hasOwnProperty(IS_TOP_ACTION_NODE))
         {
            this.isTopActionNode = param1[IS_TOP_ACTION_NODE];
         }
         if(param1.hasOwnProperty(ACTION_MESSAGE))
         {
            this.actionMessage = param1[ACTION_MESSAGE];
         }
         if(param1.hasOwnProperty(IS_FIRST_TIME_EARLY_ACCESS_SHOW))
         {
            this.isFirstTimeEarlyAccessShow = param1[IS_FIRST_TIME_EARLY_ACCESS_SHOW];
         }
         if(param1.hasOwnProperty(IS_EARLY_ACCESS_LOCKED))
         {
            this.isEarlyAccessLocked = param1[IS_EARLY_ACCESS_LOCKED];
         }
         if(param1.hasOwnProperty(IS_EARLY_ACCESS_PAUSED))
         {
            this.isEarlyAccessPaused = param1[IS_EARLY_ACCESS_PAUSED];
         }
         if(param1.hasOwnProperty(EARLY_ACCESS_CURRENT_TOKENS))
         {
            this.earlyAccessCurrentTokens = param1[EARLY_ACCESS_CURRENT_TOKENS];
         }
         if(param1.hasOwnProperty(EARLY_ACCESS_TOTAL_TOKENS))
         {
            this.earlyAccessTotalTokens = param1[EARLY_ACCESS_TOTAL_TOKENS];
         }
         if(param1.hasOwnProperty(IS_EARLY_ACCESS_CAN_BUY))
         {
            this.isEarlyAccessCanBuy = param1[IS_EARLY_ACCESS_CAN_BUY];
         }
         this.dataIsReady = true;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function setVehCompareTreeNode(param1:Object) : void
      {
         this.clearVehCompareTreeNodeVO();
         this._vehCompareTreeNodeVO = new VehCompareEntrypointTreeNodeVO(param1);
      }
      
      protected function onDispose() : void
      {
         this._disposed = true;
         this.dataIsReady = false;
         this.clearUnlockProps();
         this.clearDisplayInfo();
         this.clearVehCompareTreeNodeVO();
         this.clearBuyPrice();
      }
      
      private function clearUnlockProps() : void
      {
         if(this.unlockProps != null)
         {
            this.unlockProps.dispose();
            this.unlockProps = null;
         }
      }
      
      private function clearVehCompareTreeNodeVO() : void
      {
         if(this._vehCompareTreeNodeVO != null)
         {
            this._vehCompareTreeNodeVO.dispose();
            this._vehCompareTreeNodeVO = null;
         }
      }
      
      private function clearDisplayInfo() : void
      {
         if(this.displayInfo != null)
         {
            this.displayInfo.dispose();
            this.displayInfo = null;
         }
      }
      
      private function clearBuyPrice() : void
      {
         if(this._buyPrice != null)
         {
            this._buyPrice.dispose();
            this._buyPrice = null;
         }
      }
      
      public function get costLabel() : String
      {
         var _loc1_:int = 0;
         if(this.unlockProps != null && (this.isLocked || this.isNext2Unlock))
         {
            _loc1_ = this.unlockProps.xpCost;
         }
         else if(this._buyPrice != null)
         {
            _loc1_ = this._buyPrice.price.getPriceVO().value;
         }
         return App.utils.locale.integer(_loc1_);
      }
      
      public function get isCompareModeAvailable() : Boolean
      {
         return this._vehCompareTreeNodeVO && this._vehCompareTreeNodeVO.modeAvailable;
      }
      
      public function get isCompareBasketFull() : Boolean
      {
         return this._vehCompareTreeNodeVO && this._vehCompareTreeNodeVO.cmpBasketFull;
      }
      
      public function get blueprintLabel() : String
      {
         return this._blueprintLabel;
      }
      
      public function get blueprintProgress() : Number
      {
         return this._blueprintProgress;
      }
      
      public function get blueprintCanConvert() : Boolean
      {
         return this._blueprintCanConvert;
      }
      
      public function get buyPrice() : ItemPriceVO
      {
         return this._buyPrice;
      }
      
      public function get isNationChangeAvailable() : Boolean
      {
         return this._isNationChangeAvailable;
      }
      
      public function get hasTechTreeEvent() : Boolean
      {
         return (this.state & NODE_STATE_FLAGS.HAS_TECH_TREE_EVENT) > 0;
      }
      
      public function get isAnnouncement() : Boolean
      {
         return (this.state & NODE_STATE_FLAGS.ANNOUNCEMENT) > 0;
      }
      
      public function get isEarlyAccess() : Boolean
      {
         return (this.state & NODE_STATE_FLAGS.EARLY_ACCESS) > 0;
      }
      
      public function get isLocked() : Boolean
      {
         return (this.state & NODE_STATE_FLAGS.LOCKED) > 0;
      }
      
      public function get isNext2Unlock() : Boolean
      {
         return (this.state & NODE_STATE_FLAGS.NEXT_2_UNLOCK) > 0;
      }
   }
}
