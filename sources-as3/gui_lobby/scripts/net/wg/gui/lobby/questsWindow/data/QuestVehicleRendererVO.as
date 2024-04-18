package net.wg.gui.lobby.questsWindow.data
{
   public class QuestVehicleRendererVO extends VehicleBlockVO
   {
       
      
      private var _isAvailable:Boolean = true;
      
      private var _isDisabled:Boolean = false;
      
      private var _progressData:Object = null;
      
      private var _htmlLabel:String = "";
      
      private var _showDone:Boolean = false;
      
      public function QuestVehicleRendererVO(param1:Object)
      {
         super(param1);
      }
      
      public function get isAvailable() : Boolean
      {
         return this._isAvailable;
      }
      
      public function set isAvailable(param1:Boolean) : void
      {
         this._isAvailable = param1;
      }
      
      public function get progressData() : Object
      {
         return this._progressData;
      }
      
      public function set progressData(param1:Object) : void
      {
         this._progressData = param1;
      }
      
      public function get htmlLabel() : String
      {
         return this._htmlLabel;
      }
      
      public function set htmlLabel(param1:String) : void
      {
         this._htmlLabel = param1;
      }
      
      public function get isDisabled() : Boolean
      {
         return this._isDisabled;
      }
      
      public function set isDisabled(param1:Boolean) : void
      {
         this._isDisabled = param1;
      }
      
      public function get showDone() : Boolean
      {
         return this._showDone;
      }
      
      public function set showDone(param1:Boolean) : void
      {
         this._showDone = param1;
      }
   }
}
