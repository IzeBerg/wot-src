package net.wg.gui.notification.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.notification.constants.ButtonState;
   
   public class MessageInfoVO extends DAAPIDataClass
   {
      
      private static const BUTTONS_LAYOUT_NAME:String = "buttonsLayout";
      
      private static const BUTTONS_STATE_NAME:String = "buttonsStates";
       
      
      public var type:String = "";
      
      public var linkage:String = "";
      
      public var message:String = "";
      
      public var icon:String = "";
      
      public var defaultIcon:String = "";
      
      public var savedID:Number = -1;
      
      public var timestamp:Number = -1;
      
      public var timestampStr:String = "";
      
      public var filters:Array;
      
      public var bgIcon:String = "";
      
      public var bgIconHeight:uint = 167;
      
      public var bgIconSizeAuto:Boolean = false;
      
      public var linkageData:Object = null;
      
      public var buttonsAlign:String = "left";
      
      private var _buttonsLayout:Vector.<ButtonVO>;
      
      private var _buttonsStates:Object;
      
      public function MessageInfoVO(param1:Object)
      {
         this._buttonsLayout = new Vector.<ButtonVO>();
         this._buttonsStates = {};
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         App.utils.data.cleanupDynamicObject(this._buttonsStates);
         this._buttonsStates = null;
         if(this.filters)
         {
            this.filters.splice(0,this.filters.length);
            this.filters = null;
         }
         var _loc1_:ButtonVO = null;
         while(this._buttonsLayout.length)
         {
            _loc1_ = this._buttonsLayout.pop();
            _loc1_.dispose();
         }
         _loc1_ = null;
         this._buttonsLayout = null;
         App.utils.data.cleanupDynamicObject(this.linkageData);
         this.linkageData = null;
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         if(param1 == BUTTONS_LAYOUT_NAME)
         {
            for each(_loc3_ in param2)
            {
               this._buttonsLayout.push(new ButtonVO(_loc3_));
            }
            return false;
         }
         if(param1 == BUTTONS_STATE_NAME)
         {
            this._buttonsStates = param2;
            return false;
         }
         return this.hasOwnProperty(param1);
      }
      
      public function isButtonEnabled(param1:String) : Boolean
      {
         var _loc2_:Boolean = true;
         if(this._buttonsStates.hasOwnProperty(param1))
         {
            return (this._buttonsStates[param1] & ButtonState.ENABLED) > 0;
         }
         return _loc2_;
      }
      
      public function isButtonVisible(param1:String) : Boolean
      {
         var _loc2_:Boolean = true;
         if(this._buttonsStates.hasOwnProperty(param1))
         {
            return (this._buttonsStates[param1] & ButtonState.VISIBLE) > 0;
         }
         return _loc2_;
      }
      
      public function get buttonsLayout() : Vector.<ButtonVO>
      {
         return this._buttonsLayout;
      }
      
      public function get areButtonsVisible() : Boolean
      {
         var _loc1_:int = this._buttonsLayout.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            if(this.isButtonVisible(this._buttonsLayout[_loc2_].type))
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
   }
}
