package net.wg.gui.lobby.personalMissions.components.firstEntry
{
   import fl.motion.easing.Cubic;
   import flash.display.Sprite;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.lobby.personalMissions.data.InfoItemRendererVO;
   import net.wg.gui.lobby.personalMissions.events.FirstEntryCardEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.motion.Tween;
   
   public class InfoContent extends Sprite implements IDisposable
   {
      
      private static const START_POSITION_Y_FOR_SHOW:int = 200;
      
      private static const TWEEN_SHOW_DURATION:int = 600;
      
      private static const TWEEN_SHOW_DELAY:int = 150;
      
      private static const TWEEN_SHOW_START_DELAY:int = 400;
       
      
      private var _renderers:Vector.<InfoItemRenderer> = null;
      
      private var _renderersLen:int = 0;
      
      private var _layoutAfterInit:Boolean = false;
      
      private var _tweens:Vector.<Tween> = null;
      
      public function InfoContent()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.clearTweens();
         this.clearRenderers();
      }
      
      public function initBlocks(param1:Vector.<InfoItemRendererVO>) : void
      {
         var _loc3_:InfoItemRenderer = null;
         var _loc4_:int = 0;
         this.clearRenderers();
         this._renderers = new Vector.<InfoItemRenderer>();
         var _loc2_:int = param1.length;
         _loc3_ = null;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = App.utils.classFactory.getComponent(Linkages.PERSONAL_MISSIONS_INFO_RENDERER_UI,InfoItemRenderer);
            _loc3_.alpha = Values.ZERO;
            _loc3_.enabled = false;
            _loc3_.setData(param1[_loc4_]);
            this._renderers.push(_loc3_);
            this.addChild(_loc3_);
            _loc4_++;
         }
         this._renderersLen = _loc2_;
         this._layoutAfterInit = true;
      }
      
      public function layoutRenderers(param1:PMInfoVewSettings, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:InfoItemRenderer = null;
         var _loc6_:int = 0;
         if(this._renderers)
         {
            _loc3_ = param1.cardWidth + param1.cardGap;
            _loc4_ = -(this._renderersLen * _loc3_ - param1.cardGap >> 1);
            _loc5_ = null;
            _loc6_ = 0;
            while(_loc6_ < this._renderersLen)
            {
               _loc5_ = this._renderers[_loc6_];
               _loc5_.x = _loc4_;
               if(!this._layoutAfterInit)
               {
                  _loc5_.y = Values.ZERO;
                  _loc5_.alpha = Values.DEFAULT_ALPHA;
                  _loc5_.isAllowUseTween = true;
               }
               _loc4_ += _loc3_;
               if(param2)
               {
                  _loc5_.settings = param1;
               }
               _loc6_++;
            }
         }
         if(this._layoutAfterInit)
         {
            this._layoutAfterInit = false;
            this.showRenderers();
         }
      }
      
      public function resetShowContent() : void
      {
         this._layoutAfterInit = true;
      }
      
      private function showRenderers() : void
      {
         var _loc1_:InfoItemRenderer = null;
         var _loc2_:Tween = null;
         var _loc3_:int = 0;
         if(this._renderers)
         {
            this.clearTweens();
            this._tweens = new Vector.<Tween>();
            _loc1_ = null;
            _loc2_ = null;
            _loc3_ = 0;
            while(_loc3_ < this._renderersLen)
            {
               _loc1_ = this._renderers[_loc3_];
               _loc1_.y = START_POSITION_Y_FOR_SHOW;
               _loc1_.alpha = Values.ZERO;
               _loc1_.enabled = false;
               _loc2_ = new Tween(TWEEN_SHOW_DURATION,_loc1_,{
                  "y":Values.ZERO,
                  "alpha":Values.DEFAULT_ALPHA
               },{
                  "paused":false,
                  "ease":Cubic.easeOut,
                  "delay":TWEEN_SHOW_START_DELAY + TWEEN_SHOW_DELAY * _loc3_,
                  "fastTransform":false,
                  "onComplete":this.onShowRendererCompleted
               });
               this._tweens.push(_loc2_);
               _loc3_++;
            }
         }
      }
      
      private function clearTweens() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this._tweens)
         {
            _loc1_ = this._tweens.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this._tweens[_loc2_].dispose();
               _loc2_++;
            }
            this._tweens.splice(0,_loc1_);
            this._tweens = null;
         }
      }
      
      private function clearRenderers() : void
      {
         var _loc1_:InfoItemRenderer = null;
         var _loc2_:int = 0;
         if(this._renderers)
         {
            _loc1_ = null;
            _loc2_ = 0;
            while(_loc2_ < this._renderersLen)
            {
               _loc1_ = this._renderers.pop();
               _loc1_.removeEventListener(ButtonEvent.CLICK,this.onRendererClickHandler);
               this.removeChild(_loc1_);
               _loc1_.dispose();
               _loc2_++;
            }
         }
         this._renderers = null;
      }
      
      private function onShowRendererCompleted(param1:Tween) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc2_:InfoItemRenderer = param1.target as InfoItemRenderer;
         if(_loc2_)
         {
            _loc3_ = this._renderers.indexOf(_loc2_) == this._renderersLen - 1;
            if(_loc3_)
            {
               _loc4_ = 0;
               while(_loc4_ < this._renderersLen)
               {
                  _loc2_ = this._renderers[_loc4_];
                  _loc2_.isAllowUseTween = true;
                  _loc2_.enabled = true;
                  _loc2_.addEventListener(ButtonEvent.CLICK,this.onRendererClickHandler);
                  _loc4_++;
               }
            }
         }
      }
      
      private function onRendererClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:InfoItemRenderer = InfoItemRenderer(param1.target);
         dispatchEvent(new FirstEntryCardEvent(FirstEntryCardEvent.CARD_CLICK,_loc2_.id));
         for each(_loc2_ in this._renderers)
         {
            _loc2_.removeEventListener(ButtonEvent.CLICK,this.onRendererClickHandler);
            _loc2_.isAllowUseTween = false;
         }
      }
   }
}
