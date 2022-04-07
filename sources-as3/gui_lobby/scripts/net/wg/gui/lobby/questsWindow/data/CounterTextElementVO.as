package net.wg.gui.lobby.questsWindow.data
{
   public class CounterTextElementVO extends QuestDashlineItemVO
   {
       
      
      private var _counterValue:Number = 0;
      
      private var _showDone:Boolean = false;
      
      private var _fullLabel:String = "";
      
      private var _counterDescr:String = "";
      
      public function CounterTextElementVO(param1:Object)
      {
         super(param1);
      }
      
      public function get counterValue() : Number
      {
         return this._counterValue;
      }
      
      public function set counterValue(param1:Number) : void
      {
         this._counterValue = param1;
      }
      
      public function get showDone() : Boolean
      {
         return this._showDone;
      }
      
      public function set showDone(param1:Boolean) : void
      {
         this._showDone = param1;
      }
      
      public function get fullLabel() : String
      {
         return this._fullLabel;
      }
      
      public function set fullLabel(param1:String) : void
      {
         this._fullLabel = param1;
      }
      
      public function get counterDescr() : String
      {
         return this._counterDescr;
      }
      
      public function set counterDescr(param1:String) : void
      {
         this._counterDescr = param1;
      }
   }
}
