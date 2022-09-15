package net.wg.gui.lobby.techtree.controls
{
   import fl.motion.easing.Circular;
   import flash.display.BlendMode;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.gui.lobby.techtree.helpers.TweenWrapper;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class PremiumPanelBackground extends PremiumPanelContainer
   {
       
      
      public var bg:Sprite;
      
      public var bgTop:Sprite;
      
      public var bgGlow:Sprite;
      
      public var bgDark:Sprite;
      
      public var bgShadow:Sprite = null;
      
      public var titleTf:TextField;
      
      protected var hitMc:Sprite = null;
      
      private var _titleTweenWrapper:TweenWrapper = null;
      
      private var _bgTweenWrapper:TweenWrapper = null;
      
      private var _bgTopTweenWrapper:TweenWrapper = null;
      
      private var _bgGlowTweenWrapper:TweenWrapper = null;
      
      public function PremiumPanelBackground()
      {
         super();
         this.hitMc = new Sprite();
         addChild(this.hitMc);
         this.hitArea = this.hitMc;
         this.bgGlow.blendMode = BlendMode.SCREEN;
         this.bgGlow.mouseChildren = this.bgGlow.mouseEnabled = false;
         this.bgTop.mouseChildren = this.bgTop.mouseEnabled = false;
         this.bg.mouseChildren = this.bg.mouseEnabled = false;
         this.bgDark.mouseChildren = this.bgDark.mouseEnabled = false;
         this.bgShadow.mouseChildren = this.bgShadow.mouseEnabled = false;
         this.titleTf.blendMode = BlendMode.ADD;
         this.titleTf.alpha = 0;
         this._titleTweenWrapper = new TweenWrapper(this.titleTf);
         this._bgTweenWrapper = new TweenWrapper(this.bg);
         this._bgTopTweenWrapper = new TweenWrapper(this.bgTop);
         this._bgGlowTweenWrapper = new TweenWrapper(this.bgGlow);
      }
      
      override public function hidePanel(param1:int) : void
      {
         super.hidePanel(param1);
         tweens.push(new Tween(TWEEN_DURATION,tweenWrapper,{"y":baseY},{"ease":Circular.easeInOut}));
         tweens.push(new Tween(TWEEN_DURATION,this._bgTopTweenWrapper,{"alpha":0},{"ease":Circular.easeInOut}));
         tweens.push(new Tween(TWEEN_DURATION,this._bgTweenWrapper,{"alpha":0.6},{"ease":Circular.easeInOut}));
         tweens.push(new Tween(TWEEN_DURATION,this._bgGlowTweenWrapper,{"alpha":0},{"ease":Circular.easeInOut}));
         tweens.push(new Tween(TWEEN_DURATION,this._titleTweenWrapper,{"alpha":0},{"ease":Circular.easeInOut}));
      }
      
      override public function showPanel(param1:int) : void
      {
         super.showPanel(param1);
         tweens.push(new Tween(TWEEN_DURATION,tweenWrapper,{"y":baseY - param1},{"ease":Circular.easeInOut}));
         tweens.push(new Tween(TWEEN_DURATION,this._bgTopTweenWrapper,{"alpha":1},{"ease":Circular.easeInOut}));
         tweens.push(new Tween(TWEEN_DURATION,this._bgTweenWrapper,{"alpha":0.9},{"ease":Circular.easeInOut}));
         tweens.push(new Tween(TWEEN_DURATION,this._bgGlowTweenWrapper,{"alpha":1},{"ease":Circular.easeInOut}));
         tweens.push(new Tween(TWEEN_DURATION,this._titleTweenWrapper,{"alpha":1},{"ease":Circular.easeInOut}));
      }
      
      override protected function onDispose() : void
      {
         this._titleTweenWrapper.dispose();
         this._titleTweenWrapper = null;
         this._bgTweenWrapper.dispose();
         this._bgTweenWrapper = null;
         this._bgTopTweenWrapper.dispose();
         this._bgTopTweenWrapper = null;
         this._bgGlowTweenWrapper.dispose();
         this._bgGlowTweenWrapper = null;
         this.bg = null;
         this.bgTop = null;
         this.bgGlow = null;
         this.bgShadow = null;
         this.bgDark = null;
         this.titleTf = null;
         if(this.hitMc != null)
         {
            removeChild(this.hitMc);
            this.hitMc = null;
         }
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            height = contentHeight;
            this.bg.width = contentWidth;
            this.bg.height = contentHeight;
            this.bgDark.width = contentWidth;
            this.bgDark.height = contentHeight;
            this.bgShadow.width = contentWidth;
            this.bgTop.x = contentWidth - this.bgTop.width >> 1;
            this.bgGlow.x = contentWidth - this.bgGlow.width >> 1;
            this.titleTf.width = contentWidth;
         }
      }
      
      public function set panelTitle(param1:String) : void
      {
         this.titleTf.htmlText = param1;
         var _loc2_:TextFormat = this.titleTf.getTextFormat();
         _loc2_.letterSpacing = 5;
         this.titleTf.setTextFormat(_loc2_);
      }
   }
}
