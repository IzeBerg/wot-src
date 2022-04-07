package net.wg.gui.lobby.battleResults.components
{
   import flash.text.TextField;
   import net.wg.gui.lobby.battleResults.data.DetailedStatsItemVO;
   
   public class IncomeDetailsShort extends IncomeDetailsBase
   {
       
      
      public var col2:TextField;
      
      public var col4:TextField;
      
      public function IncomeDetailsShort()
      {
         super();
      }
      
      override public function setColumnsAlpha(param1:Number, param2:Number) : void
      {
         this.col2.alpha = param1;
         this.col4.alpha = param2;
      }
      
      override protected function onDispose() : void
      {
         this.col2 = null;
         this.col4 = null;
         super.onDispose();
      }
      
      override protected function initColumns() : Vector.<TextField>
      {
         return new <TextField>[this.col2,this.col4];
      }
      
      override protected function setColumnsData(param1:DetailedStatsItemVO) : void
      {
         this.col2.htmlText += param1.col2;
         this.col4.htmlText += param1.col4;
      }
   }
}
