package net.wg.gui.lobby.questsWindow.components
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.lobby.questsWindow.data.ConditionSeparatorVO;
   import scaleform.clik.constants.InvalidationType;
   
   public class ConditionSeparator extends AbstractResizableContent
   {
      
      private static const PADDING:int = 5;
      
      private static const RIGHT_ALIGN_PADDING:int = 140;
       
      
      public var separatorTF:TextField;
      
      private var data:ConditionSeparatorVO = null;
      
      public function ConditionSeparator()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.separatorTF = null;
         if(this.data)
         {
            this.data.dispose();
            this.data = null;
         }
         super.onDispose();
      }
      
      override public function setData(param1:Object) : void
      {
         if(this.data)
         {
            this.data.dispose();
         }
         this.data = new ConditionSeparatorVO(param1);
         invalidateData();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA) && this.data)
         {
            this.separatorTF.htmlText = this.data.text;
            this.separatorTF.height = this.separatorTF.textHeight + PADDING;
            this.layoutComponents();
         }
      }
      
      private function layoutComponents() : void
      {
         if(isNumerated && this.data.needAlign)
         {
            this.separatorTF.x = PADDING * 3;
         }
         if(contentAlign == TextFieldAutoSize.RIGHT)
         {
            this.separatorTF.x += RIGHT_ALIGN_PADDING;
         }
         this.setSize(this.width,this.separatorTF.textHeight + PADDING);
         isReadyForLayout = true;
      }
   }
}
