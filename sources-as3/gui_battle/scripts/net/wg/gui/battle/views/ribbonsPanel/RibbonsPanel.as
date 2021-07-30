package net.wg.gui.battle.views.ribbonsPanel
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import net.wg.gui.battle.views.ribbonsPanel.data.RibbonQueueItem;
   import net.wg.gui.components.ribbon.data.RibbonSettings;
   import net.wg.infrastructure.base.meta.IRibbonsPanelMeta;
   import net.wg.infrastructure.base.meta.impl.RibbonsPanelMeta;
   
   public class RibbonsPanel extends RibbonsPanelMeta implements IRibbonsPanelMeta
   {
      
      private static const MAX_COUNT_RIBBONS:int = 3;
       
      
      private var _calculatedMaxCountRenderers:int = 0;
      
      private var _isVisible:Boolean = false;
      
      private var _ribbonQueue:RibbonQueue = null;
      
      private var _visibleItems:Vector.<RibbonCtrl> = null;
      
      private var _isShowPlaying:Boolean = false;
      
      private var _isHidePlaying:Boolean = false;
      
      private var _countVisibleItems:int = 0;
      
      private var _countHidedItems:int = 0;
      
      private var _ribbonPool:RibbonsPool = null;
      
      private var _visibleItemsById:Dictionary = null;
      
      private var _textsSprite:Sprite = null;
      
      private var _bonusSprite:Sprite = null;
      
      private var _offsetX:int = 0;
      
      private var _bonusLabels:Vector.<String> = null;
      
      public function RibbonsPanel()
      {
         super();
         this._visibleItemsById = new Dictionary();
         this._visibleItems = new Vector.<RibbonCtrl>();
         this._ribbonQueue = new RibbonQueue();
         this._bonusSprite = new Sprite();
         addChild(this._bonusSprite);
         this._textsSprite = new Sprite();
         addChild(this._textsSprite);
         mouseChildren = mouseEnabled = false;
         visible = false;
         this._bonusLabels = new Vector.<String>(0);
      }
      
      override protected function onDispose() : void
      {
         if(this._ribbonPool != null)
         {
            this._ribbonPool.dispose();
            this._ribbonPool = null;
         }
         removeChild(this._bonusSprite);
         removeChild(this._textsSprite);
         this._textsSprite = null;
         this._bonusSprite = null;
         this.reset();
         this._ribbonQueue.dispose();
         this._ribbonQueue = null;
         this._visibleItems = null;
         this._visibleItemsById = null;
         this._bonusLabels.length = 0;
         this._bonusLabels = null;
         super.onDispose();
      }
      
      override protected function setup(param1:Array, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean, param6:Array) : void
      {
         var _loc7_:String = null;
         if(this._ribbonPool == null)
         {
            this._ribbonPool = new RibbonsPool(this,this._textsSprite,this._bonusSprite,param1,this.animationCallback);
         }
         this.setSettings(param3,param2,param4,param5);
         for each(_loc7_ in param6)
         {
            this._bonusLabels.push(_loc7_);
         }
      }
      
      public function as_addBattleEfficiencyEvent(param1:String, param2:Number, param3:String, param4:String, param5:String, param6:String, param7:int, param8:String) : void
      {
         var _loc9_:RibbonCtrl = null;
         if(this._isShowPlaying || this._isHidePlaying)
         {
            this._ribbonQueue.pushShow(param1,param2,param3,param4,param5,param6,true,this.getBonusLabel(param7),param8);
         }
         else
         {
            _loc9_ = this._ribbonPool.getItemFromPool(param1);
            this._visibleItemsById[param2] = _loc9_;
            this._isShowPlaying = true;
            this.shiftItems();
            this._visibleItems.push(_loc9_);
            _loc9_.updateData(param2,param3,param4,param5,param6,this.getBonusLabel(param7),param8);
            _loc9_.showAnim(this._countVisibleItems);
            ++this._countVisibleItems;
            onShowS(param2);
         }
      }
      
      public function as_reset() : void
      {
         this.reset();
      }
      
      public function as_setSettings(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean) : void
      {
         this.setSettings(param1,param2,param3,param4);
      }
      
      public function as_updateBattleEfficiencyEvent(param1:String, param2:Number, param3:String, param4:String, param5:String, param6:String, param7:int, param8:String) : void
      {
         var _loc9_:RibbonCtrl = this._visibleItemsById[param2];
         if(_loc9_ != null)
         {
            _loc9_.updateData(param2,param3,param4,param5,param6,this.getBonusLabel(param7),param8);
            onChangeS();
         }
         else
         {
            this._ribbonQueue.pushShow(param1,param2,param3,param4,param5,param6,false,this.getBonusLabel(param7),param8);
         }
      }
      
      public function setFreeWorkingHeight(param1:int) : void
      {
         this._calculatedMaxCountRenderers = Math.min(param1 / RibbonCtrl.ITEM_HEIGHT ^ 0,MAX_COUNT_RIBBONS);
      }
      
      public function setSettings(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean) : void
      {
         if(param1 != this._isVisible)
         {
            this._isVisible = param1;
            visible = param1;
         }
         this._ribbonPool.setSettings(param2,param3,param4);
         this._offsetX = RibbonSettings.getPaddings(param3,param4).ribbonOffset;
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function shiftItems() : void
      {
         var _loc1_:RibbonCtrl = null;
         var _loc2_:int = this._countVisibleItems;
         var _loc3_:Boolean = _loc2_ == this._calculatedMaxCountRenderers;
         var _loc4_:int = 0;
         if(_loc3_)
         {
            _loc4_ = 1;
            _loc1_ = this._visibleItems[0];
            _loc1_.hideInBottom();
            ++this._countHidedItems;
            this._isHidePlaying = true;
         }
         while(_loc4_ < _loc2_)
         {
            _loc1_ = this._visibleItems[_loc4_];
            _loc1_.shiftAnim(_loc4_);
            _loc4_++;
         }
      }
      
      private function reset() : void
      {
         var _loc1_:RibbonCtrl = null;
         this._countHidedItems = 0;
         this._countVisibleItems = 0;
         this._isShowPlaying = false;
         this._isHidePlaying = false;
         this._ribbonQueue.clear();
         for each(_loc1_ in this._visibleItems)
         {
            _loc1_.hideImmediately();
         }
         this._visibleItems.splice(0,this._visibleItems.length);
         App.utils.data.cleanupDynamicObject(this._visibleItemsById);
      }
      
      private function onShowAnimComplete() : void
      {
         this._isShowPlaying = false;
         this.checkQueue();
      }
      
      private function onHideAnimationComplete() : void
      {
         var _loc1_:RibbonCtrl = this._visibleItems.shift();
         var _loc2_:Number = _loc1_.ribbonId;
         this._ribbonPool.returnInPool(_loc1_);
         delete this._visibleItemsById[_loc2_];
         onHideS(_loc2_);
         --this._countVisibleItems;
         --this._countHidedItems;
         if(this._countHidedItems == 0)
         {
            this._isHidePlaying = false;
            this.checkQueue();
         }
      }
      
      private function checkQueue() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:RibbonCtrl = null;
         var _loc4_:Boolean = false;
         var _loc1_:RibbonQueueItem = this._ribbonQueue.readNext();
         if(_loc1_ != null)
         {
            _loc2_ = _loc1_.ribbonId;
            if(_loc1_.animationType == RibbonQueueItem.SHOW && !this._isShowPlaying)
            {
               _loc4_ = _loc1_.isNew;
               if(!_loc4_)
               {
                  _loc3_ = this._visibleItemsById[_loc2_];
                  onChangeS();
               }
               if(_loc4_ || _loc3_ == null)
               {
                  _loc3_ = this._ribbonPool.getItemFromPool(_loc1_.ribbonType);
                  this._isShowPlaying = true;
                  this.shiftItems();
                  _loc3_.showAnim(this._countVisibleItems);
                  this._visibleItems.push(_loc3_);
                  this._visibleItemsById[_loc2_] = _loc3_;
                  ++this._countVisibleItems;
                  onShowS(_loc3_.ribbonId);
               }
               _loc3_.updateData(_loc2_,_loc1_.valueStr,_loc1_.vehName,_loc1_.vehType,_loc1_.countVehs,_loc1_.bonusLabel,_loc1_.role);
               this._ribbonQueue.shiftQueue();
               if(!_loc4_)
               {
                  this.checkQueue();
               }
            }
            else if(_loc1_.animationType == RibbonQueueItem.HIDE)
            {
               this.hideByOrder(_loc1_.ribbonId);
               this._ribbonQueue.shiftQueue();
            }
         }
      }
      
      private function animationCallback(param1:String, param2:Number) : void
      {
         if(param1 == RibbonCtrl.CALLBACK_TYPE_SHOW_FINISHED)
         {
            this.onShowAnimComplete();
         }
         else if(param1 == RibbonCtrl.CALLBACK_TYPE_HIDE_FINISHED)
         {
            this.onHideAnimationComplete();
         }
         else if(param1 == RibbonCtrl.CALLBACK_LIFETIME_COOLDOWN)
         {
            if(this._isShowPlaying || this._isHidePlaying)
            {
               this._ribbonQueue.unShiftHide(param2);
            }
            else
            {
               this.hideByOrder(param2);
            }
         }
      }
      
      private function hideByOrder(param1:Number) : void
      {
         var _loc2_:RibbonCtrl = this._visibleItemsById[param1];
         var _loc3_:int = this._visibleItems.indexOf(_loc2_);
         while(_loc3_ >= 0)
         {
            this._isHidePlaying = true;
            ++this._countHidedItems;
            this._visibleItems[_loc3_].hideByOrder(_loc3_);
            _loc3_--;
         }
      }
      
      private function getBonusLabel(param1:int) : String
      {
         return param1 > -1 ? this._bonusLabels[param1] : null;
      }
      
      public function get freeHeightForRenderers() : int
      {
         return this._calculatedMaxCountRenderers * RibbonCtrl.ITEM_HEIGHT;
      }
      
      public function get offsetX() : int
      {
         return this._offsetX;
      }
   }
}
