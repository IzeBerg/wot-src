package net.wg.gui.battle.battleRoyale.views
{
   import flash.display.MovieClip;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.battleRoyale.views.components.BattleRoyaleWinnerCongratsAnimation;
   import net.wg.gui.battle.battleRoyale.views.shamrock.components.results.WinnerShamrockAnimation;
   import net.wg.infrastructure.base.meta.IBattleRoyaleWinnerCongratsMeta;
   import net.wg.infrastructure.base.meta.impl.BattleRoyaleWinnerCongratsMeta;
   import net.wg.utils.IClassFactory;
   
   public class BattleRoyaleWinnerCongrats extends BattleRoyaleWinnerCongratsMeta implements IBattleRoyaleWinnerCongratsMeta
   {
      
      private static const FRAME_START:int = 1;
      
      private static const VERTICAL_ALIGNMENT_PERCENT:Number = 0.2;
      
      private static const ANIMATION_UI:String = "BRWinnerCongratsAnimationUI";
      
      private static const VIGNETTE_MC:String = "BRWinnerCongratsVignetteMC";
      
      private static const GRADIENT_MC:String = "BRWinnerCongratsGradientMC";
      
      private static const SHAMROCK_ANIMATION_MC:String = "BRWinnerShamrockAnimationUI";
      
      private static const SHAMROCK_ANIMATION_Y_OFFSET:int = 210;
       
      
      private var _animation:BattleRoyaleWinnerCongratsAnimation = null;
      
      private var _vignette:MovieClip = null;
      
      private var _gradient:MovieClip = null;
      
      private var _shamrockAnimation:WinnerShamrockAnimation = null;
      
      private var _classFactory:IClassFactory = null;
      
      private var _stageWidth:int = 0;
      
      private var _stageHeight:int = 0;
      
      private var _isInitialized:Boolean = false;
      
      public function BattleRoyaleWinnerCongrats()
      {
         super();
         this.setCompVisible(false);
         this._classFactory = App.instance.utils.classFactory;
      }
      
      override public function setCompVisible(param1:Boolean) : void
      {
         super.setCompVisible(param1);
         if(param1)
         {
            if(!this._isInitialized)
            {
               this.initContent();
            }
            this._animation.gotoAndPlay(FRAME_START);
            this._vignette.gotoAndPlay(FRAME_START);
            this._gradient.gotoAndPlay(FRAME_START);
            this._shamrockAnimation.gotoAndPlay(FRAME_START);
            onBecomeVisibleS();
         }
         else if(this._isInitialized)
         {
            this._animation.stop();
            this._vignette.stop();
            this._gradient.stop();
            this._shamrockAnimation.stop();
         }
      }
      
      override protected function onDispose() : void
      {
         this._gradient = null;
         this._vignette = null;
         if(this._shamrockAnimation)
         {
            this._shamrockAnimation.stop();
            this._shamrockAnimation = null;
         }
         if(this._isInitialized)
         {
            this._animation.dispose();
            this._animation = null;
         }
         this._isInitialized = false;
         this._classFactory = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._isInitialized && isInvalid(InvalidationType.SIZE))
         {
            this._gradient.x = this._vignette.x = 0;
            this._gradient.y = this._vignette.y = 0;
            this._gradient.width = this._vignette.width = this._stageWidth;
            this._gradient.height = this._vignette.height = this._stageHeight;
            this._animation.x = this._stageWidth >> 1;
            this._animation.y = this._stageHeight * VERTICAL_ALIGNMENT_PERCENT >> 0;
            this._shamrockAnimation.x = this._stageWidth >> 1;
            this._shamrockAnimation.y = this._animation.y + SHAMROCK_ANIMATION_Y_OFFSET;
         }
      }
      
      public function as_setStpCoins(param1:int, param2:int, param3:int) : void
      {
         if(this._shamrockAnimation)
         {
            this._shamrockAnimation.setValues(param1,param2,param3);
         }
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this._stageWidth = param1;
         this._stageHeight = param2;
         invalidateSize();
      }
      
      private function initContent() : void
      {
         if(this._classFactory)
         {
            this._animation = this._classFactory.getComponent(ANIMATION_UI,BattleRoyaleWinnerCongratsAnimation);
            this._vignette = this._classFactory.getComponent(VIGNETTE_MC,MovieClip);
            this._gradient = this._classFactory.getComponent(GRADIENT_MC,MovieClip);
            this._shamrockAnimation = this._classFactory.getComponent(SHAMROCK_ANIMATION_MC,WinnerShamrockAnimation);
            addChild(this._animation);
            addChild(this._vignette);
            addChild(this._gradient);
            addChild(this._shamrockAnimation);
            invalidateSize();
            this._isInitialized = true;
         }
      }
   }
}
