package net.wg.gui.battle.views.perksPanel
{
   import flash.display.MovieClip;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.battle.views.perksPanel.components.PerkItem;
   import net.wg.gui.battle.views.perksPanel.data.PerkItemVO;
   import net.wg.gui.battle.views.perksPanel.events.PerkItemEvent;
   import net.wg.gui.bootcamp.containers.AnimatedSpriteContainer;
   import net.wg.infrastructure.base.meta.IPerksPanelMeta;
   import net.wg.infrastructure.base.meta.impl.PerksPanelMeta;
   import net.wg.utils.IClassFactory;
   import scaleform.clik.motion.Tween;
   
   public class PerksPanel extends PerksPanelMeta implements IPerksPanelMeta
   {
      
      private static const PERK_GAP:int = 10;
      
      private static const PERK_WIDTH:int = 30;
      
      private static const ANIMATION_DELAY_COEFFICIENT:Number = 1.66;
      
      private static const UPDATE_POS_DELAY:int = 30;
      
      private static const PERK_FULL_WIDTH:int = PERK_GAP + PERK_WIDTH;
      
      private static const HALF_PERK_FULL_WIDTH:int = PERK_FULL_WIDTH >> 1;
       
      
      public var wrapper:AnimatedSpriteContainer = null;
      
      public var glowWrapper:MovieClip = null;
      
      private var _perksList:Vector.<PerkItem>;
      
      private var _perkTweens:Vector.<Tween>;
      
      private var _wrapperTween:Tween = null;
      
      private var _classFactory:IClassFactory;
      
      private var _skippAnim:Boolean = false;
      
      public function PerksPanel()
      {
         this._perksList = new Vector.<PerkItem>();
         this._perkTweens = new Vector.<Tween>();
         this._classFactory = App.utils.classFactory;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.addEventListener(PerkItemEvent.SHOW_ANIM_COMPLETE,this.onPerkShowAnimCompleteHandler,true);
         this.addEventListener(PerkItemEvent.HIDE_ANIM_COMPLETE,this.onPerkHideAnimCompleteHandler,true);
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.POSITION))
         {
            this.updatePerksPositions();
            this.updatePanelPosition();
            this._skippAnim = false;
         }
      }
      
      override protected function setPerks(param1:Vector.<PerkItemVO>) : void
      {
         var _loc2_:PerkItemVO = null;
         var _loc3_:int = 0;
         var _loc4_:int = param1.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc2_ = param1[_loc3_];
            if(_loc2_.state == PerkItemVO.STATE_ACTIVE)
            {
               this.addPerk(_loc2_.perkName,_loc2_.state,_loc2_.duration,_loc2_.lifeTime);
            }
            _loc3_++;
         }
         this._skippAnim = true;
         invalidatePosition();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:PerkItem = null;
         var _loc2_:Tween = null;
         this.removeEventListener(PerkItemEvent.HIDE_ANIM_COMPLETE,this.onPerkHideAnimCompleteHandler);
         this.removeEventListener(PerkItemEvent.SHOW_ANIM_COMPLETE,this.onPerkShowAnimCompleteHandler);
         this.wrapper.dispose();
         this.wrapper = null;
         this.glowWrapper = null;
         for each(_loc1_ in this._perksList)
         {
            _loc1_.dispose();
         }
         this._perksList.splice(0,this._perksList.length);
         this._perksList = null;
         if(this._wrapperTween)
         {
            this._wrapperTween.paused = true;
            this._wrapperTween.dispose();
            this._wrapperTween = null;
         }
         for each(_loc2_ in this._perkTweens)
         {
            _loc2_.paused = true;
            _loc2_.dispose();
         }
         this._perkTweens.splice(0,this._perkTweens.length);
         this._perkTweens = null;
         this._classFactory = null;
         super.onDispose();
      }
      
      public function as_clearPanel() : void
      {
         var _loc1_:PerkItem = null;
         for each(_loc1_ in this._perksList)
         {
            this.wrapper.removeContent(_loc1_);
            _loc1_.dispose();
         }
         this._perksList.splice(0,this._perksList.length);
         invalidatePosition();
      }
      
      public function as_updatePerk(param1:String, param2:int, param3:Number, param4:Number) : void
      {
         var _loc5_:PerkItem = this.getPerkByName(param1);
         if(_loc5_)
         {
            _loc5_.update(param2,param3,param4);
         }
         else if(param2 != PerkItemVO.STATE_INACTIVE)
         {
            this.addPerk(param1,param2,param3,param4);
            invalidatePosition();
         }
      }
      
      protected function updatePerksPositions() : void
      {
         var _loc2_:int = 0;
         var _loc3_:PerkItem = null;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc1_:int = this._perksList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._perksList[_loc2_];
            _loc4_ = _loc2_ * PERK_FULL_WIDTH;
            if(this._skippAnim)
            {
               _loc3_.x = _loc4_;
            }
            else
            {
               _loc5_ = Math.abs(_loc3_.x - _loc4_);
               _loc6_ = _loc5_ * ANIMATION_DELAY_COEFFICIENT;
               this._perkTweens.push(new Tween(_loc6_,_loc3_,{"x":_loc4_}));
            }
            _loc2_++;
         }
      }
      
      protected function updatePanelPosition() : void
      {
         var _loc3_:Number = NaN;
         if(this._wrapperTween)
         {
            this._wrapperTween.dispose();
            this._wrapperTween = null;
         }
         var _loc1_:int = this._perksList.length;
         var _loc2_:int = -_loc1_ * HALF_PERK_FULL_WIDTH + HALF_PERK_FULL_WIDTH;
         if(this._skippAnim)
         {
            this.wrapper.x = _loc2_;
         }
         else
         {
            _loc3_ = Math.abs(this.wrapper.x - _loc1_ * HALF_PERK_FULL_WIDTH);
            this._wrapperTween = new Tween(_loc3_,this.wrapper,{"x":_loc2_},{"delay":UPDATE_POS_DELAY});
         }
      }
      
      private function addPerk(param1:String, param2:int, param3:Number, param4:Number) : void
      {
         var _loc5_:PerkItem = this._classFactory.getComponent(Linkages.PERK_ITEM_UI,PerkItem);
         _loc5_.perkName = param1;
         _loc5_.update(param2,param3,param4);
         this._perksList.push(_loc5_);
         this.wrapper.addContent(_loc5_);
      }
      
      private function removePerk(param1:PerkItem) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:int = this._perksList.indexOf(param1);
         this._perksList.splice(_loc2_,1);
         this.wrapper.removeContent(param1);
         param1.dispose();
         param1 = null;
         invalidatePosition();
      }
      
      private function getPerkByName(param1:String) : PerkItem
      {
         var _loc2_:PerkItem = null;
         for each(_loc2_ in this._perksList)
         {
            if(_loc2_.perkName == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function onPerkShowAnimCompleteHandler(param1:PerkItemEvent) : void
      {
         param1.stopPropagation();
         invalidatePosition();
      }
      
      private function onPerkHideAnimCompleteHandler(param1:PerkItemEvent) : void
      {
         param1.stopPropagation();
         this.removePerk(PerkItem(param1.target));
      }
   }
}
