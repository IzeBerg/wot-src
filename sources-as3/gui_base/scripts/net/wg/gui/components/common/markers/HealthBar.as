package net.wg.gui.components.common.markers
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class HealthBar extends UIComponentEx
   {
      
      private static const ORIGINAL_SPLASH_WIDTH:int = 26;
      
      private static const HEALTH_BAR_WIDTH:int = 70;
      
      private static const INVALIDATE_COLOR:String = "invalidateColor";
      
      private static const INVALIDATE_BAR:String = "invalidateBar";
       
      
      public var healthBar:MovieClip;
      
      public var hitSplash:HealthBarAnimatedPart;
      
      private var _color:String = "green";
      
      private var _maxHealth:Number = NaN;
      
      private var _curHealth:Number = NaN;
      
      private var _isSplashRunning:Boolean = false;
      
      private var beforeLastHit:Number;
      
      public function HealthBar()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         this.hitSplash.addEventListener(HealthBarAnimatedPart.SHOW,this.onHitSplashShowHandler);
         this.hitSplash.addEventListener(HealthBarAnimatedPart.HIDE,this.onHitSplashHideHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         super.draw();
         if(isInvalid(INVALIDATE_COLOR))
         {
            gotoAndStop(this._color);
         }
         if(!isNaN(this.maxHealth) && !isNaN(this.curHealth) && isInvalid(INVALIDATE_BAR))
         {
            _loc1_ = this.curHealth / this.maxHealth;
            _loc2_ = Math.ceil(_loc1_ * (this.healthBar.totalFrames - 1)) + 1;
            this.healthBar.gotoAndStop(_loc2_);
         }
      }
      
      public function updateHealth(param1:Number, param2:String) : void
      {
         if(this.maxHealth == 0)
         {
            return;
         }
         this.hitSplash.setAnimationType(param2);
         if(!this.isSplashRunning)
         {
            this.beforeLastHit = this.curHealth;
         }
         this.curHealth = param1;
         this._isSplashRunning = true;
         this.hitSplash.x = this.getXForHealth(this.curHealth,true);
         var _loc3_:int = this.getXForHealth(this.beforeLastHit,false) - this.hitSplash.x;
         this.hitSplash.scaleX = _loc3_ / ORIGINAL_SPLASH_WIDTH;
         this.hitSplash.playShowTween();
      }
      
      private function getXForHealth(param1:Number, param2:Boolean) : Number
      {
         var _loc4_:Number = NaN;
         var _loc3_:Number = 0;
         if(!isNaN(this.maxHealth) && this.maxHealth != 0)
         {
            _loc4_ = HEALTH_BAR_WIDTH * (param1 / this.maxHealth);
            _loc3_ = !!param2 ? Number(Math.floor(_loc4_)) : Number(Math.round(_loc4_));
         }
         return _loc3_ > 0 ? Number(_loc3_) : Number(0);
      }
      
      public function get color() : String
      {
         return this._color;
      }
      
      public function set color(param1:String) : void
      {
         if(param1 == this._color)
         {
            return;
         }
         this._color = param1;
         invalidate(INVALIDATE_COLOR);
      }
      
      public function get maxHealth() : Number
      {
         return this._maxHealth;
      }
      
      public function set maxHealth(param1:Number) : void
      {
         this._maxHealth = param1;
         invalidate(INVALIDATE_BAR);
      }
      
      public function get curHealth() : Number
      {
         return this._curHealth;
      }
      
      public function set curHealth(param1:Number) : void
      {
         this._curHealth = param1;
         this._curHealth = this._curHealth >= 0 ? Number(this._curHealth) : Number(0);
         invalidate(INVALIDATE_BAR);
      }
      
      public function get isSplashRunning() : Boolean
      {
         return this._isSplashRunning;
      }
      
      private function onHitSplashShowHandler(param1:Event) : void
      {
         invalidate(INVALIDATE_BAR);
      }
      
      private function onHitSplashHideHandler(param1:Event) : void
      {
         this._isSplashRunning = false;
      }
   }
}
