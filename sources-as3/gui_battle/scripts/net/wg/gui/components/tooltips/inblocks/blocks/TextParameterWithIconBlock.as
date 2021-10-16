package net.wg.gui.components.tooltips.inblocks.blocks
{
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.tooltips.inblocks.data.TextParameterWithIconVO;
   
   public class TextParameterWithIconBlock extends AbstractTextParameterBlock
   {
      
      private static const ICON_WIDTH:int = 21;
       
      
      public var iconText:IconText = null;
      
      public function TextParameterWithIconBlock()
      {
         super();
         this.iconText.setTextMultiline(true,true);
         this.iconText.setFixedIconWidth(true,ICON_WIDTH);
      }
      
      override protected function onSetBlockWidth(param1:int) : void
      {
         if(param1 > 0)
         {
            this.iconText.setTextWidth(param1 - this.iconText.x - ICON_WIDTH);
         }
      }
      
      override public function getHeight() : Number
      {
         return this.iconText.height;
      }
      
      override protected function getDataClass() : Class
      {
         return TextParameterWithIconVO;
      }
      
      override protected function onDispose() : void
      {
         this.iconText.dispose();
         this.iconText = null;
         super.onDispose();
      }
      
      override protected function applyParamName() : void
      {
         var _loc1_:TextParameterWithIconVO = TextParameterWithIconVO(_data);
         this.iconText.useHtmlText = _loc1_.useHtmlName;
         this.iconText.text = _loc1_.name;
         if(_loc1_.icon != null && _loc1_.icon != Values.EMPTY_STR)
         {
            this.iconText.icon = _loc1_.icon;
         }
         if(_loc1_.nameOffset != -1)
         {
            this.iconText.xCorrect = _loc1_.nameOffset;
         }
         if(_loc1_.gap != -1)
         {
            this.iconText.x = valueTF.width + _data.gap;
         }
      }
   }
}
