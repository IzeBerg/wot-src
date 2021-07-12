package net.wg.gui.lobby.manualChapter.controls
{
   import net.wg.gui.bootcamp.containers.AnimatedSpriteContainer;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.lobby.manualChapter.data.ManualChapterHintVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class HintRenderer extends UIComponentEx
   {
       
      
      public var txtDescription:TextContainer;
      
      public var hintIcon:AnimatedSpriteContainer;
      
      public var loader:UILoaderAlt;
      
      private var _vo:ManualChapterHintVO;
      
      private var _scale:Number = 1;
      
      private var _stateLabel:String = "";
      
      private const OUT_LABEL:String = "out";
      
      private const IN_LABEL:String = "in";
      
      private const HINT_TOP_OFFSET:int = 53;
      
      private const TEXT_TOP_OFFSET:int = 113;
      
      public function HintRenderer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.loader.autoSize = false;
         this.hintIcon.addContent(this.loader);
         this.loader.addEventListener(UILoaderEvent.COMPLETE,this.onLoaderCompleteHandler);
      }
      
      override protected function onDispose() : void
      {
         this.txtDescription.dispose();
         this.txtDescription = null;
         this.hintIcon.dispose();
         this.hintIcon = null;
         this.loader.removeEventListener(UILoaderEvent.COMPLETE,this.onLoaderCompleteHandler);
         this.loader.dispose();
         this.loader = null;
         this._vo = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            this.txtDescription.gotoAndPlay(this._stateLabel);
            this.hintIcon.gotoAndPlay(this._stateLabel);
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.hintIcon.scaleX = this.hintIcon.scaleY = this._scale;
            this.hintIcon.y = this._scale * this.HINT_TOP_OFFSET;
            this.txtDescription.y = this._scale * this.TEXT_TOP_OFFSET;
            this.txtDescription.updateScaleFactor(this._scale);
         }
         if(isInvalid(InvalidationType.DATA))
         {
            this.loader.source = this._vo.icon;
         }
         if(isInvalid(InvalidationType.DATA,InvalidationType.SIZE))
         {
            this.updateLabel();
            height = this.txtDescription.y + this.txtDescription.contentHeight;
         }
      }
      
      public function fadeIn() : void
      {
         this._stateLabel = this.IN_LABEL;
         invalidateState();
      }
      
      public function fadeOut() : void
      {
         this._stateLabel = this.OUT_LABEL;
         invalidateState();
      }
      
      public function setData(param1:ManualChapterHintVO) : void
      {
         this._vo = param1;
         invalidateData();
      }
      
      public function updateScaleFactor(param1:Number) : void
      {
         this._scale = param1;
         invalidateSize();
      }
      
      private function updateLabel() : void
      {
         if(this._vo)
         {
            this.txtDescription.text = this._vo.text;
         }
      }
      
      private function onLoaderCompleteHandler(param1:UILoaderEvent) : void
      {
         this.loader.x = -this.loader.width >> 1;
         this.loader.y = -this.loader.height >> 1;
      }
   }
}
