package net.wg.gui.lobby.battleResults.components
{
   import flash.text.TextField;
   import net.wg.gui.lobby.battleResults.data.DetailedStatsItemVO;
   import scaleform.gfx.TextFieldEx;
   
   public class IncomeDetails extends IncomeDetailsBase
   {
       
      
      public var col1:TextField;
      
      public var col2:TextField;
      
      public var col3:TextField;
      
      public var col4:TextField;
      
      public function IncomeDetails()
      {
         super();
      }
      
      override public function setColumnsAlpha(param1:Number, param2:Number) : void
      {
         this.col1.alpha = param1;
         this.col2.alpha = param1;
         this.col3.alpha = param2;
         this.col4.alpha = param2;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         TextFieldEx.setVerticalAlign(this.col1,TextFieldEx.VALIGN_TOP);
         TextFieldEx.setVerticalAlign(this.col2,TextFieldEx.VALIGN_TOP);
         TextFieldEx.setVerticalAlign(this.col3,TextFieldEx.VALIGN_TOP);
         TextFieldEx.setVerticalAlign(this.col4,TextFieldEx.VALIGN_TOP);
         TextFieldEx.setVerticalAlign(label,TextFieldEx.VALIGN_TOP);
      }
      
      override protected function onDispose() : void
      {
         this.col1 = null;
         this.col2 = null;
         this.col3 = null;
         this.col4 = null;
         super.onDispose();
      }
      
      override protected function initColumns() : Vector.<TextField>
      {
         return new <TextField>[this.col1,this.col2,this.col3,this.col4];
      }
      
      override protected function setColumnsData(param1:DetailedStatsItemVO) : void
      {
         this.col1.htmlText += param1.col1;
         this.col2.htmlText += param1.col2;
         this.col3.htmlText += param1.col3;
         this.col4.htmlText += param1.col4;
      }
   }
}
