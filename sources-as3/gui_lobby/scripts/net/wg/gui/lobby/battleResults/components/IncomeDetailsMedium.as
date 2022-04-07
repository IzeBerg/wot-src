package net.wg.gui.lobby.battleResults.components
{
   import flash.text.TextField;
   import net.wg.gui.lobby.battleResults.data.DetailedStatsItemVO;
   import scaleform.gfx.TextFieldEx;
   
   public class IncomeDetailsMedium extends IncomeDetailsSmall
   {
       
      
      public var col3:TextField = null;
      
      public function IncomeDetailsMedium()
      {
         super();
      }
      
      override public function setColumnsAlpha(param1:Number, param2:Number) : void
      {
         col1.alpha = param1;
         this.col3.alpha = param2;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         TextFieldEx.setVerticalAlign(this.col3,TextFieldEx.VALIGN_TOP);
      }
      
      override protected function onDispose() : void
      {
         this.col3 = null;
         super.onDispose();
      }
      
      override protected function initColumns() : Vector.<TextField>
      {
         return new <TextField>[col1,this.col3];
      }
      
      override protected function setColumnsData(param1:DetailedStatsItemVO) : void
      {
         col1.htmlText += param1.col1;
         this.col3.htmlText += param1.col3;
      }
   }
}
