package net.wg.gui.lobby.manualChapter.controls
{
   import fl.transitions.easing.Regular;
   import flash.events.Event;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.bootcamp.controls.BCHighlightRendererBase;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.manualChapter.data.ManualChapterButtonVO;
   import net.wg.gui.lobby.manualChapter.events.ManualViewEvent;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.motion.Tween;
   
   public class PageWithButtonContainer extends PageContentTemplate
   {
      
      private static const TWEEN_DURATION:int = 300;
       
      
      public var button:ISoundButtonEx;
      
      private var _tweens:Vector.<Tween>;
      
      private var _vo:ManualChapterButtonVO = null;
      
      private var _hintStart:BCHighlightRendererBase = null;
      
      public function PageWithButtonContainer()
      {
         this._tweens = new Vector.<Tween>(0);
         super();
      }
      
      override public function fadeIn() : void
      {
         this.button.alpha = 0;
         this._tweens.push(new Tween(TWEEN_DURATION,this.button,{"alpha":1},{
            "paused":false,
            "ease":Regular.easeIn
         }));
         this.addHintStart();
      }
      
      override public function fadeOut() : void
      {
         this._tweens.push(new Tween(TWEEN_DURATION,this.button,{"alpha":0},{
            "paused":false,
            "ease":Regular.easeIn
         }));
         this.removeHintStart();
      }
      
      override public function isCentered() : Boolean
      {
         return true;
      }
      
      override public function isSeparated() : Boolean
      {
         return false;
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         this._vo = ManualChapterButtonVO(getData());
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.button.addEventListener(ButtonEvent.CLICK,this.onButtonClickHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.button.label = this._vo.text;
         }
      }
      
      override protected function onDispose() : void
      {
         this.removeHintStart();
         this.button.removeEventListener(ButtonEvent.CLICK,this.onButtonClickHandler);
         this.button.dispose();
         this.button = null;
         this.disposeTweens();
         this._tweens = null;
         this._vo = null;
         super.onDispose();
      }
      
      override protected function getDataVO(param1:Object) : IDAAPIDataClass
      {
         return new ManualChapterButtonVO(param1);
      }
      
      private function disposeTweens() : void
      {
         var _loc1_:Tween = null;
         for each(_loc1_ in this._tweens)
         {
            _loc1_.paused = true;
            _loc1_.dispose();
         }
         this._tweens.splice(0,this._tweens.length);
      }
      
      private function onButtonClickHandler(param1:Event) : void
      {
         dispatchEvent(new ManualViewEvent(ManualViewEvent.BUTTON_CLICKED,true));
      }
      
      private function addHintStart() : void
      {
         if(this._hintStart == null)
         {
            this._hintStart = App.utils.classFactory.getComponent(Linkages.LOBBY_HINT_UI,BCHighlightRendererBase);
            this._hintStart.x = this.button.x;
            this._hintStart.y = this.button.y;
            this._hintStart.setProperties(this.button.width,this.button.height,true);
            addChild(this._hintStart);
         }
      }
      
      private function removeHintStart() : void
      {
         if(this._hintStart != null)
         {
            removeChild(this._hintStart);
            this._hintStart.dispose();
            this._hintStart = null;
         }
      }
   }
}
