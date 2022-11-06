package net.wg.gui.bootcamp.subtitles
{
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.base.meta.ISubtitlesWindowMeta;
   import net.wg.infrastructure.base.meta.impl.SubtitlesWindowMeta;
   import scaleform.clik.constants.InvalidationType;
   
   public class SubtitlesWindow extends SubtitlesWindowMeta implements ISubtitlesWindowMeta
   {
      
      private static const STAGE_RESIZE:String = "stageResize";
      
      private static const SUBTITLE_OFFSET:int = 70;
       
      
      public var subtitle:BCSubtitle = null;
      
      private var _text:String = null;
      
      public function SubtitlesWindow()
      {
         super();
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         setActualSize(param1,param2);
         invalidate(STAGE_RESIZE);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         mouseChildren = mouseEnabled = false;
         this.updatePositions();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(STAGE_RESIZE))
         {
            this.updatePositions();
         }
         if(this._text != null && isInvalid(InvalidationType.DATA))
         {
            this.subtitle.setText(this._text);
            this.subtitle.visible = this._text != Values.EMPTY_STR;
         }
      }
      
      override protected function onDispose() : void
      {
         this.subtitle.dispose();
         this.subtitle = null;
         super.onDispose();
      }
      
      private function updatePositions() : void
      {
         this.subtitle.x = _width >> 1;
         this.subtitle.y = _height - SUBTITLE_OFFSET;
      }
      
      public function as_showSubtitle(param1:String) : void
      {
         this._text = param1;
         invalidateData();
      }
      
      public function as_hideSubtitle() : void
      {
         this._text = Values.EMPTY_STR;
         invalidateData();
      }
   }
}
