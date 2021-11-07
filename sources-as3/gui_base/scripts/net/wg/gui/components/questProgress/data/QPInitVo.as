package net.wg.gui.components.questProgress.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.questProgress.interfaces.data.IQPInitData;
   
   public class QPInitVo extends DAAPIDataClass implements IQPInitData
   {
       
      
      private var _description:String = "";
      
      private var _title:String = "";
      
      private var _iconID:String = "";
      
      private var _orderType:String = "";
      
      private var _progressType:String = "";
      
      private var _topMetricIndex:int = -1;
      
      private var _alertLabel:String = "";
      
      private var _multiplier:String = "";
      
      private var _isInOrGroup:Boolean = false;
      
      private var _isHiddenInBattleHud:Boolean = false;
      
      private var _tooltip:String = "";
      
      public function QPInitVo(param1:Object = null)
      {
         super(param1);
      }
      
      public function get description() : String
      {
         return this._description;
      }
      
      public function set description(param1:String) : void
      {
         this._description = param1;
      }
      
      public function get title() : String
      {
         return this._title;
      }
      
      public function set title(param1:String) : void
      {
         this._title = param1;
      }
      
      public function get iconID() : String
      {
         return this._iconID;
      }
      
      public function set iconID(param1:String) : void
      {
         this._iconID = param1;
      }
      
      public function get orderType() : String
      {
         return this._orderType;
      }
      
      public function set orderType(param1:String) : void
      {
         this._orderType = param1;
      }
      
      public function get progressType() : String
      {
         return this._progressType;
      }
      
      public function set progressType(param1:String) : void
      {
         this._progressType = param1;
      }
      
      public function get topMetricIndex() : int
      {
         return this._topMetricIndex;
      }
      
      public function set topMetricIndex(param1:int) : void
      {
         this._topMetricIndex = param1;
      }
      
      public function get alertLabel() : String
      {
         return this._alertLabel;
      }
      
      public function set alertLabel(param1:String) : void
      {
         this._alertLabel = param1;
      }
      
      public function get multiplier() : String
      {
         return this._multiplier;
      }
      
      public function set multiplier(param1:String) : void
      {
         this._multiplier = param1;
      }
      
      public function get isInOrGroup() : Boolean
      {
         return this._isInOrGroup;
      }
      
      public function set isInOrGroup(param1:Boolean) : void
      {
         this._isInOrGroup = param1;
      }
      
      public function get isHiddenInBattleHud() : Boolean
      {
         return this._isHiddenInBattleHud;
      }
      
      public function set isHiddenInBattleHud(param1:Boolean) : void
      {
         this._isHiddenInBattleHud = param1;
      }
      
      public function get tooltip() : String
      {
         return this._tooltip;
      }
      
      public function set tooltip(param1:String) : void
      {
         this._tooltip = param1;
      }
   }
}
