package net.wg.gui.lobby.referralSystem
{
   import flash.display.Sprite;
   import net.wg.gui.components.advanced.interfaces.IComplexProgressStepRenderer;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.lobby.referralSystem.data.ProgressStepVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class ProgressStepRenderer extends UIComponentEx implements IComplexProgressStepRenderer
   {
      
      private static const DEF_ICON_HEIGHT:Number = 24;
       
      
      public var icon:UILoaderAlt = null;
      
      public var line:Sprite = null;
      
      private var _id:String = null;
      
      private var _showLine:Boolean = true;
      
      public function ProgressStepRenderer()
      {
         super();
         this.icon.autoSize = false;
      }
      
      override protected function onDispose() : void
      {
         this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler);
         this.icon.dispose();
         this.icon = null;
         this.line = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.icon.x = -this.icon.width >> 1;
            this.icon.y = DEF_ICON_HEIGHT - this.icon.height >> 1;
         }
      }
      
      public function setData(param1:ProgressStepVO) : void
      {
         this.icon.addEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler);
         this.icon.source = param1.icon;
         this._id = param1.id;
      }
      
      public function get showLine() : Boolean
      {
         return this._showLine;
      }
      
      public function set showLine(param1:Boolean) : void
      {
         this._showLine = param1;
         this.line.visible = this._showLine;
      }
      
      private function onIconCompleteHandler(param1:UILoaderEvent) : void
      {
         this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler);
         invalidateSize();
      }
   }
}
