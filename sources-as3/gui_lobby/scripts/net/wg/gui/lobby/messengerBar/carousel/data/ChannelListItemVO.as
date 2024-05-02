package net.wg.gui.lobby.messengerBar.carousel.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ChannelListItemVO extends DAAPIDataClass
   {
      
      private static const excluded:Array = ["order"];
       
      
      private var _clientID:Number = 0;
      
      private var _label:String = "";
      
      private var _canClose:Boolean = false;
      
      private var _isNotified:Boolean = false;
      
      private var _icon:String = "";
      
      private var _isInProgress:Boolean = false;
      
      private var _isWindowFocused:Boolean = false;
      
      private var _isWindowOpened:Boolean = false;
      
      private var _readyData:Object;
      
      private var _readyDataVO:ReadyDataVO;
      
      private var _tooltipDataVO:TooltipDataVO;
      
      private var _tooltipData:Object;
      
      public function ChannelListItemVO(param1:Object)
      {
         super(param1);
      }
      
      public function get clientID() : Number
      {
         return this._clientID;
      }
      
      public function set clientID(param1:Number) : void
      {
         this._clientID = param1;
      }
      
      public function get label() : String
      {
         return this._label;
      }
      
      public function set label(param1:String) : void
      {
         this._label = App.utils.locale.makeString(param1);
      }
      
      public function get canClose() : Boolean
      {
         return this._canClose;
      }
      
      public function set canClose(param1:Boolean) : void
      {
         this._canClose = param1;
      }
      
      public function get isNotified() : Boolean
      {
         return this._isNotified;
      }
      
      public function set isNotified(param1:Boolean) : void
      {
         this._isNotified = param1;
      }
      
      public function get icon() : String
      {
         return this._icon;
      }
      
      public function set icon(param1:String) : void
      {
         this._icon = param1;
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(excluded.indexOf(param1) > -1)
         {
            return false;
         }
         if(param1 == "readyData" && param2)
         {
            this._readyDataVO = new ReadyDataVO(param2);
         }
         else if(param1 == "tooltipData" && param2)
         {
            this._tooltipDataVO = new TooltipDataVO(param2);
         }
         return super.onDataWrite(param1,param2);
      }
      
      public function get isInProgress() : Boolean
      {
         return this._isInProgress;
      }
      
      public function set isInProgress(param1:Boolean) : void
      {
         this._isInProgress = param1;
      }
      
      public function get isWindowFocused() : Boolean
      {
         return this._isWindowFocused;
      }
      
      public function set isWindowFocused(param1:Boolean) : void
      {
         this._isWindowFocused = param1;
      }
      
      public function get isWindowOpened() : Boolean
      {
         return this._isWindowOpened;
      }
      
      public function set isWindowOpened(param1:Boolean) : void
      {
         this._isWindowOpened = param1;
      }
      
      public function get readyData() : Object
      {
         return this._readyData;
      }
      
      public function set readyData(param1:Object) : void
      {
         this._readyData = param1;
      }
      
      public function get readyDataVO() : ReadyDataVO
      {
         return this._readyDataVO;
      }
      
      public function get tooltipData() : Object
      {
         return this._tooltipData;
      }
      
      public function set tooltipData(param1:Object) : void
      {
         this._tooltipData = param1;
      }
      
      public function get tooltipDataVO() : TooltipDataVO
      {
         return this._tooltipDataVO;
      }
   }
}
