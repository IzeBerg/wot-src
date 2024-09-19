package net.wg.gui.battle.views.situationIndicators
{
   import com.gskinner.motion.GTweener;
   import com.gskinner.motion.easing.Cubic;
   import flash.display.MovieClip;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Time;
   import net.wg.gui.battle.views.situationIndicators.components.PerkItem;
   import net.wg.gui.battle.views.situationIndicators.components.WeatherItem;
   import net.wg.gui.battle.views.situationIndicators.data.PerkItemVO;
   import net.wg.gui.battle.views.situationIndicators.data.WeatherItemVO;
   import net.wg.gui.battle.views.situationIndicators.events.SituationIndicatorsPanelEvent;
   import net.wg.gui.components.containers.AnimatedSpriteContainer;
   import net.wg.infrastructure.base.meta.ISituationIndicatorsMeta;
   import net.wg.infrastructure.base.meta.impl.SituationIndicatorsMeta;
   import net.wg.utils.IClassFactory;
   
   public class SituationIndicatorsPanel extends SituationIndicatorsMeta implements ISituationIndicatorsMeta
   {
      
      private static const ITEM_GAP:int = 10;
      
      private static const ITEM_WIDTH:int = 30;
      
      private static const ANIMATION_SPEED_PER_PX:Number = 10;
      
      private static const ITEM_FULL_WIDTH:int = ITEM_GAP + ITEM_WIDTH;
      
      private static const HALF_ITEM_FULL_WIDTH:int = ITEM_FULL_WIDTH >> 1;
      
      private static const SEPARATOR_NAME:String = "groupSeparator";
      
      private static const PERK_ITEM_UI_LINKAGE:String = "PerkItemUI";
      
      private static const WEATHER_ITEM_UI_LINKAGE:String = "WeatherItemUI";
      
      private static const SEPARATOR_UI_LINKAGE:String = "PerksSeparatorUI";
      
      private static const GROUPS_GAP:int = 12;
      
      private static const SEPARATOR_Y:int = -12;
       
      
      public var wrapper:AnimatedSpriteContainer = null;
      
      public var glowWrapper:MovieClip = null;
      
      private var _perksList:Vector.<PerkItem>;
      
      private var _weatherList:Vector.<WeatherItem>;
      
      private var _separator:MovieClip = null;
      
      private var _classFactory:IClassFactory;
      
      private var _skipAnim:Boolean = false;
      
      public function SituationIndicatorsPanel()
      {
         this._perksList = new Vector.<PerkItem>();
         this._weatherList = new Vector.<WeatherItem>();
         this._classFactory = App.utils.classFactory;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.addEventListener(SituationIndicatorsPanelEvent.SHOW_ITEM_ANIM_COMPLETE,this.onItemShowAnimCompleteHandler,true);
         this.addEventListener(SituationIndicatorsPanelEvent.HIDE_ITEM_ANIM_COMPLETE,this.onItemHideAnimCompleteHandler,true);
         var _loc1_:Class = this._classFactory.getClass(SEPARATOR_UI_LINKAGE);
         if(_loc1_)
         {
            this._separator = this._classFactory.getComponent(SEPARATOR_UI_LINKAGE,MovieClip);
         }
         if(this._separator)
         {
            this._separator.name = SEPARATOR_NAME;
            this._separator.visible = false;
            this._separator.y = SEPARATOR_Y;
            this.wrapper.addContent(this._separator);
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.POSITION))
         {
            this.updateItemsPositions();
            this.updatePanelPosition();
            this._skipAnim = false;
         }
      }
      
      override protected function setPerks(param1:Vector.<PerkItemVO>) : void
      {
         var _loc2_:PerkItemVO = null;
         this.clearPerks();
         for each(_loc2_ in param1)
         {
            if(_loc2_.state == PerkItemVO.STATE_ACTIVE)
            {
               this.addPerk(_loc2_.perkName,_loc2_.state,_loc2_.duration,_loc2_.lifeTime);
            }
         }
         this._skipAnim = true;
         invalidatePosition();
      }
      
      override protected function setWeather(param1:Vector.<WeatherItemVO>) : void
      {
         var _loc2_:WeatherItemVO = null;
         this.clearWeather();
         for each(_loc2_ in param1)
         {
            if(_loc2_.state == WeatherItemVO.STATE_ACTIVE)
            {
               this.addWeather(_loc2_.weatherName,_loc2_.state,_loc2_.toolTip);
            }
         }
         this._skipAnim = true;
         invalidatePosition();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:PerkItem = null;
         var _loc2_:WeatherItem = null;
         this.removeEventListener(SituationIndicatorsPanelEvent.HIDE_ITEM_ANIM_COMPLETE,this.onItemHideAnimCompleteHandler);
         this.removeEventListener(SituationIndicatorsPanelEvent.SHOW_ITEM_ANIM_COMPLETE,this.onItemShowAnimCompleteHandler);
         this.wrapper.dispose();
         this.wrapper = null;
         this.glowWrapper = null;
         for each(_loc1_ in this._perksList)
         {
            GTweener.removeTweens(_loc1_);
            _loc1_.dispose();
         }
         this._perksList.length = 0;
         this._perksList = null;
         for each(_loc2_ in this._weatherList)
         {
            GTweener.removeTweens(_loc2_);
            _loc2_.dispose();
         }
         this._weatherList.length = 0;
         this._weatherList = null;
         this._separator = null;
         this._classFactory = null;
         super.onDispose();
      }
      
      public function as_clearPanel() : void
      {
         if(this._separator)
         {
            this._separator.visible = false;
         }
         this.clearPerks();
         this.clearWeather();
      }
      
      public function as_replayPause(param1:Boolean) : void
      {
         var _loc2_:PerkItem = null;
         for each(_loc2_ in this._perksList)
         {
            _loc2_.pause(param1);
         }
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
      
      public function as_updateWeather(param1:String, param2:int, param3:String) : void
      {
         var _loc4_:WeatherItem = this.getWeatherByName(param1);
         if(_loc4_)
         {
            _loc4_.state = param2;
            _loc4_.toolTip = param3;
         }
         else if(param2 != WeatherItemVO.STATE_INACTIVE)
         {
            this.addWeather(param1,param2,param3);
            invalidatePosition();
         }
      }
      
      protected function updateItemsPositions() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:WeatherItem = null;
         var _loc5_:PerkItem = null;
         var _loc6_:int = 0;
         _loc1_ = this._weatherList.length;
         _loc2_ = this._perksList.length;
         var _loc7_:Boolean = _loc2_ > 0 && _loc1_ > 0;
         var _loc8_:int = this.getItemsStartPosition();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc5_ = this._perksList[_loc3_];
            _loc6_ = _loc8_ + _loc3_ * ITEM_FULL_WIDTH;
            this.animateItem(_loc5_,_loc6_,this._skipAnim);
            _loc3_++;
         }
         _loc6_ += ITEM_FULL_WIDTH + GROUPS_GAP >> 1;
         if(this._separator)
         {
            if(_loc7_ && this._separator.visible)
            {
               this.animateItem(this._separator,_loc6_,this._skipAnim);
            }
            else
            {
               this._separator.x = _loc6_;
               this._separator.visible = _loc7_;
            }
         }
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc4_ = this._weatherList[_loc3_];
            _loc6_ = _loc8_ + (_loc2_ + _loc3_) * ITEM_FULL_WIDTH;
            if(_loc2_ > 0)
            {
               _loc6_ += GROUPS_GAP;
            }
            this.animateItem(_loc4_,_loc6_,this._skipAnim);
            _loc3_++;
         }
      }
      
      protected function updatePanelPosition() : void
      {
      }
      
      protected function isSkipAnim() : Boolean
      {
         return this._skipAnim;
      }
      
      protected function getPerksList() : Vector.<PerkItem>
      {
         return this._perksList;
      }
      
      private function animateItem(param1:MovieClip, param2:int, param3:Boolean) : void
      {
         var _loc4_:Number = NaN;
         if(param1.x == param2)
         {
            return;
         }
         if(param3)
         {
            param1.x = param2;
         }
         else
         {
            _loc4_ = Math.abs(param1.x - param2) * ANIMATION_SPEED_PER_PX / Time.MILLISECOND_IN_SECOND;
            GTweener.to(param1,_loc4_,{"x":param2},{"ease":Cubic.easeOut});
         }
      }
      
      private function addPerk(param1:String, param2:int, param3:Number, param4:Number) : void
      {
         var _loc5_:PerkItem = this._classFactory.getComponent(PERK_ITEM_UI_LINKAGE,PerkItem);
         _loc5_.perkName = param1;
         _loc5_.update(param2,param3,param4);
         var _loc6_:int = this._perksList.length;
         var _loc7_:int = this.getItemsStartPosition();
         if(_loc6_ == 0 && this._weatherList.length > 0)
         {
            _loc7_ -= GROUPS_GAP >> 1;
         }
         _loc5_.x = _loc7_ + _loc6_ * ITEM_FULL_WIDTH;
         this._perksList.push(_loc5_);
         this.wrapper.addContent(_loc5_);
      }
      
      private function addWeather(param1:String, param2:int, param3:String) : void
      {
         var _loc4_:WeatherItem = this._classFactory.getComponent(WEATHER_ITEM_UI_LINKAGE,WeatherItem);
         _loc4_.weatherName = param1;
         _loc4_.state = param2;
         _loc4_.toolTip = param3;
         var _loc5_:int = this._weatherList.length;
         var _loc6_:int = this.getItemsStartPosition();
         if(this._perksList.length > 0 && _loc5_ == 0)
         {
            _loc6_ -= GROUPS_GAP >> 1;
         }
         _loc4_.x = _loc6_ + _loc5_ * ITEM_FULL_WIDTH;
         this._weatherList.push(_loc4_);
         this.wrapper.addContent(_loc4_);
      }
      
      private function getItemsStartPosition() : int
      {
         var _loc1_:int = this._perksList.length + this._weatherList.length;
         var _loc2_:int = _loc1_ > 0 ? int((1 - _loc1_) * HALF_ITEM_FULL_WIDTH) : int(0);
         if(this._perksList.length > 0 && this._weatherList.length > 0)
         {
            _loc2_ -= GROUPS_GAP >> 1;
         }
         return _loc2_;
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
         invalidatePosition();
      }
      
      private function removeWeather(param1:WeatherItem) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:int = this._weatherList.indexOf(param1);
         this._weatherList.splice(_loc2_,1);
         this.wrapper.removeContent(param1);
         param1.dispose();
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
      
      private function getWeatherByName(param1:String) : WeatherItem
      {
         var _loc2_:WeatherItem = null;
         for each(_loc2_ in this._weatherList)
         {
            if(_loc2_.weatherName == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function clearPerks() : void
      {
         var _loc1_:PerkItem = null;
         for each(_loc1_ in this._perksList)
         {
            this.wrapper.removeContent(_loc1_);
            _loc1_.dispose();
         }
         this._perksList.length = 0;
         invalidatePosition();
      }
      
      private function clearWeather() : void
      {
         var _loc1_:WeatherItem = null;
         for each(_loc1_ in this._weatherList)
         {
            this.wrapper.removeContent(_loc1_);
            _loc1_.dispose();
         }
         this._weatherList.length = 0;
         invalidatePosition();
      }
      
      private function onItemShowAnimCompleteHandler(param1:SituationIndicatorsPanelEvent) : void
      {
         param1.stopPropagation();
         invalidatePosition();
      }
      
      private function onItemHideAnimCompleteHandler(param1:SituationIndicatorsPanelEvent) : void
      {
         param1.stopPropagation();
         this.removePerk(param1.target as PerkItem);
         this.removeWeather(param1.target as WeatherItem);
      }
   }
}
