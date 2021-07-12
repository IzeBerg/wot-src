package net.wg.gui.tutorial.controls
{
   import flash.display.MovieClip;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.UILoaderAlt;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.ListItemRenderer;
   
   public class ChapterProgressItemRenderer extends ListItemRenderer
   {
      
      private static const TEXT_DELIMETER_STEP:Number = 4;
       
      
      public var textDelimeter:MovieClip;
      
      public var resultIcon:UILoaderAlt;
      
      public function ChapterProgressItemRenderer()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         super.data = param1;
         invalidate(InvalidationType.DATA);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         textField.autoSize = TextFieldAutoSize.LEFT;
         buttonMode = useHandCursor = false;
      }
      
      override protected function onDispose() : void
      {
         this.resultIcon.dispose();
         this.resultIcon = null;
         this.textDelimeter = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(_data)
            {
               visible = true;
               _loc1_ = Math.min(Math.ceil(textField.textWidth / TEXT_DELIMETER_STEP) + 1,this.textDelimeter.totalFrames);
               this.textDelimeter.gotoAndStop(_loc1_);
               if(_data.done)
               {
                  this.resultIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_COMPLETE;
               }
               else
               {
                  this.resultIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_DOT;
               }
            }
            else
            {
               visible = false;
            }
         }
      }
   }
}
