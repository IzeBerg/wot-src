package net.wg.gui.lobby.training
{
   import scaleform.clik.controls.ListItemRenderer;
   
   public class MapsListItemRenderer extends ListItemRenderer
   {
      
      private static const MAX_WIDTH:uint = 239;
      
      private static const CONDITIONS_INFO_OFFSET_X:uint = 13;
       
      
      public var additionalInfo:AdditionalInfo = null;
      
      public function MapsListItemRenderer()
      {
         super();
      }
      
      override public function setActualSize(param1:Number, param2:Number) : void
      {
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         if(!param1)
         {
            return;
         }
         this.additionalInfo.visible = param1.additionalInfo;
         if(param1.additionalInfo)
         {
            this.additionalInfo.setType(param1.additionalInfo);
         }
      }
      
      override protected function onDispose() : void
      {
         this.additionalInfo.dispose();
         this.additionalInfo = null;
         super.onDispose();
      }
      
      override protected function updateText() : void
      {
         super.updateText();
         if(textField != null)
         {
            if(textField.width > MAX_WIDTH)
            {
               textField.width = MAX_WIDTH;
            }
            this.additionalInfo.x = textField.textWidth + CONDITIONS_INFO_OFFSET_X | 0;
            if(this.additionalInfo.x > width - this.additionalInfo.width)
            {
               this.additionalInfo.x = width - this.additionalInfo.width;
            }
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.additionalInfo.visible = false;
      }
   }
}
