package net.wg.gui.lobby.modulesPanel.data
{
   public class FittingSelectPopoverParams
   {
       
      
      private var _slotType:String;
      
      private var _slotIndex:int;
      
      private var _preferredLayout:int;
      
      public function FittingSelectPopoverParams(param1:String, param2:int = -1, param3:int = -1)
      {
         super();
         this._slotType = param1;
         this._slotIndex = param2;
         this._preferredLayout = param3;
      }
      
      public function get slotType() : String
      {
         return this._slotType;
      }
      
      public function get slotIndex() : int
      {
         return this._slotIndex;
      }
      
      public function get preferredLayout() : int
      {
         return this._preferredLayout;
      }
   }
}
