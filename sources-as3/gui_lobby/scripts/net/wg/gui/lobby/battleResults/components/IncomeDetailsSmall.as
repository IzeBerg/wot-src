package net.wg.gui.lobby.battleResults.components
{
   import flash.text.TextField;
   import net.wg.gui.lobby.battleResults.data.DetailedStatsItemVO;
   import scaleform.gfx.TextFieldEx;
   
   public class IncomeDetailsSmall extends IncomeDetailsBase
   {
       
      
      public var col1:TextField = null;
      
      public function IncomeDetailsSmall()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         TextFieldEx.setVerticalAlign(this.col1,TextFieldEx.VALIGN_TOP);
         TextFieldEx.setVerticalAlign(label,TextFieldEx.VALIGN_TOP);
      }
      
      override public function setColumnsAlpha(param1:Number, param2:Number) : void
      {
      }
      
      override protected function onDispose() : void
      {
         this.col1 = null;
         super.onDispose();
      }
      
      override protected function initColumns() : Vector.<TextField>
      {
         return new <TextField>[this.col1];
      }
      
      override protected function setColumnsData(param1:DetailedStatsItemVO) : void
      {
         this.col1.htmlText += param1.col1;
      }
   }
}
