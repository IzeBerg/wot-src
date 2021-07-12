package net.wg.gui.components.controls
{
   import flash.display.MovieClip;
   import net.wg.gui.events.UILoaderEvent;
   
   public class ListItemRedererImageText extends DropDownListItemRendererSound
   {
       
      
      public var icon:UILoaderAlt;
      
      public var ico_border:MovieClip;
      
      public function ListItemRedererImageText()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         this.ico_border.visible = false;
         super.configUI();
         if(this.data)
         {
            this.setup();
         }
      }
      
      override public function setData(param1:Object) : void
      {
         this.data = param1;
         invalidate("data");
      }
      
      private function setup() : void
      {
         if(data)
         {
            this.textField.text = data.label;
            this.icon.visible = true;
            this.icon.addEventListener(UILoaderEvent.COMPLETE,this.completeLoadA);
            this.icon.source = data.icon;
         }
      }
      
      protected function completeLoadA(param1:UILoaderEvent) : void
      {
         this.ico_border.visible = true;
         if(this.icon.hasEventListener(UILoaderEvent.COMPLETE))
         {
            this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.completeLoadA);
         }
      }
      
      override protected function draw() : void
      {
         if(isInvalid("data"))
         {
            this.setup();
         }
         super.draw();
      }
   }
}
