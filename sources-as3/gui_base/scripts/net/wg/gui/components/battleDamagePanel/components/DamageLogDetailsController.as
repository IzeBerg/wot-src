package net.wg.gui.components.battleDamagePanel.components
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.gui.components.battleDamagePanel.constants.BattleDamageLogConstants;
   import net.wg.gui.components.battleDamagePanel.models.MessageRenderModel;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class DamageLogDetailsController implements IDisposable
   {
      
      private static const LOG_RENDERER_ALIAS:String = "LogRendererUI";
       
      
      private var _scrollPosition:int = 0;
      
      private var _totalFilledData:int = 0;
      
      private var _poolRenderers:Vector.<DamageLogRenderer> = null;
      
      private var _lastYValue:int = 0;
      
      private var _damageLogDetailsImages:Sprite = null;
      
      private var _damageLogDetailsText:Sprite = null;
      
      private var _visibilityRowsCount:int = 6;
      
      private var _ctrlButton:Boolean = true;
      
      private var _nextItemInPoolIdx:int = 0;
      
      private var _rendererClass:Class = null;
      
      private var _isTop:Boolean = false;
      
      private var _isColorBlind:Boolean = false;
      
      private var _isCroppedBG:Boolean = false;
      
      private var _atlasName:String = "";
      
      private var _isShortMode:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      public function DamageLogDetailsController(param1:DisplayObjectContainer, param2:Boolean, param3:String)
      {
         super();
         this._atlasName = param3;
         this._isTop = param2;
         this._rendererClass = App.utils.classFactory.getClass(LOG_RENDERER_ALIAS);
         this._damageLogDetailsImages = new Sprite();
         this._damageLogDetailsText = new Sprite();
         param1.addChild(this._damageLogDetailsImages);
         param1.addChild(this._damageLogDetailsText);
         this._damageLogDetailsText.mouseEnabled = false;
         this._damageLogDetailsText.mouseChildren = false;
         param1.addEventListener(MouseEvent.MOUSE_WHEEL,this.onDmgLogDetailsImagesMouseWheelHandler);
         this._poolRenderers = new Vector.<DamageLogRenderer>();
      }
      
      private static function changeRendererVisible(param1:DamageLogRenderer, param2:Boolean) : void
      {
         param1.visible = param2;
         param1.externalImagesContainer.visible = param2;
      }
      
      public function addDetailsMessage(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String) : void
      {
         if(this._nextItemInPoolIdx >= this._poolRenderers.length)
         {
            this.makePool(1);
         }
         this.fillNextData(param1,param2,param3,param4,param5,param6);
      }
      
      public function detailsStats(param1:Boolean, param2:Boolean, param3:Vector.<MessageRenderModel>) : void
      {
         var _loc4_:MessageRenderModel = null;
         this.resetData();
         this._isShortMode = param2;
         if(param3.length >= this._poolRenderers.length)
         {
            this.makePool(param3.length - this._poolRenderers.length);
         }
         for each(_loc4_ in param3)
         {
            this.fillNextData(_loc4_.value,_loc4_.actionTypeImg,_loc4_.vehicleTypeImg,_loc4_.vehicleName,_loc4_.shellTypeStr,_loc4_.shellTypeBG);
         }
         this.changeContainerVisibility(param1);
      }
      
      public final function dispose() : void
      {
         var _loc1_:DamageLogRenderer = null;
         this._disposed = true;
         this._damageLogDetailsImages.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onDmgLogDetailsImagesMouseWheelHandler);
         for each(_loc1_ in this._poolRenderers)
         {
            _loc1_.dispose();
         }
         this._rendererClass = null;
         this._poolRenderers.splice(0,this._poolRenderers.length);
         this._poolRenderers = null;
         this._damageLogDetailsImages = null;
         this._damageLogDetailsText = null;
      }
      
      public function isDownAltButton(param1:Boolean) : void
      {
         this.changeContainerVisibility(param1);
         this.showLastItems();
      }
      
      public function isDownCtrlButton(param1:Boolean) : void
      {
         this._ctrlButton = param1;
         this.showLastItems();
      }
      
      public function setColorBlind(param1:Boolean) : void
      {
         var _loc2_:DamageLogRenderer = null;
         this._isColorBlind = param1;
         for each(_loc2_ in this._poolRenderers)
         {
            _loc2_.updateSettings(param1);
         }
      }
      
      public function setDetailsCount(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this._scrollPosition <= Math.min(this._visibilityRowsCount,param1))
         {
            this._visibilityRowsCount = param1;
            return;
         }
         var _loc4_:Boolean = this._visibilityRowsCount < param1;
         if(_loc4_)
         {
            _loc2_ = this._scrollPosition - this._visibilityRowsCount - 1;
            _loc3_ = Math.max(this._scrollPosition - param1,0);
         }
         else
         {
            _loc2_ = this._scrollPosition - param1 - 1;
            _loc3_ = Math.max(this._scrollPosition - this._visibilityRowsCount,0);
         }
         while(_loc2_ >= _loc3_)
         {
            changeRendererVisible(this._poolRenderers[_loc2_],_loc4_);
            _loc2_--;
         }
         this._visibilityRowsCount = param1;
      }
      
      public function updateRenderersBG(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this._isCroppedBG != param1)
         {
            this._isCroppedBG = param1;
            _loc2_ = this._poolRenderers.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               this._poolRenderers[_loc3_].updateBG(param1,this._isTop);
               _loc3_++;
            }
         }
      }
      
      private function showLastItems() : void
      {
         this.scroll(this._totalFilledData);
      }
      
      private function scroll(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = this._scrollPosition + param1;
         if(param1 > 0 && _loc2_ > this._totalFilledData)
         {
            param1 = this._totalFilledData - this._scrollPosition;
         }
         else if(this._totalFilledData > this._visibilityRowsCount && param1 < 0 && _loc2_ < this._visibilityRowsCount)
         {
            param1 = this._visibilityRowsCount - this._scrollPosition;
         }
         if(param1 == 0)
         {
            return;
         }
         _loc2_ = this._scrollPosition + param1;
         _loc3_ = param1 / Math.abs(param1);
         var _loc4_:Boolean = _loc3_ > 0;
         while(this._scrollPosition != _loc2_)
         {
            if(_loc4_)
            {
               changeRendererVisible(this._poolRenderers[this._scrollPosition],true);
               if(this._scrollPosition >= this._visibilityRowsCount)
               {
                  changeRendererVisible(this._poolRenderers[this._scrollPosition - this._visibilityRowsCount],false);
               }
            }
            else
            {
               changeRendererVisible(this._poolRenderers[this._scrollPosition - this._visibilityRowsCount - 1],true);
               changeRendererVisible(this._poolRenderers[this._scrollPosition - 1],false);
            }
            this._scrollPosition += _loc3_;
         }
         var _loc5_:int = BattleDamageLogConstants.RENDER_STEP_SIZE * this._scrollPosition;
         this._damageLogDetailsImages.y = _loc5_;
         this._damageLogDetailsText.y = _loc5_;
      }
      
      private function makePool(param1:int) : void
      {
         var _loc3_:Sprite = null;
         var _loc5_:DamageLogRenderer = null;
         var _loc2_:int = this._atlasName == ATLAS_CONSTANTS.BATTLE_ATLAS ? int(Math.max(BattleDamageLogConstants.DEFAULT_POOL_COUNT,param1)) : int(BattleDamageLogConstants.SETTINGS_POOL_COUNT);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = new Sprite();
            _loc3_.visible = false;
            this._damageLogDetailsImages.addChild(_loc3_);
            this._lastYValue += -BattleDamageLogConstants.RENDER_STEP_SIZE;
            _loc5_ = new this._rendererClass();
            _loc5_.init(_loc3_,!this._isTop || this._isCroppedBG,this._isTop,this._atlasName);
            _loc3_.y += this._lastYValue;
            _loc5_.y += this._lastYValue;
            _loc5_.visible = false;
            this._damageLogDetailsImages.addChild(_loc5_);
            this._poolRenderers.push(_loc5_);
            _loc4_++;
         }
      }
      
      private function fillNextData(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String) : void
      {
         var _loc7_:DamageLogRenderer = this._poolRenderers[this._nextItemInPoolIdx];
         ++this._nextItemInPoolIdx;
         _loc7_.setData(param1,param2,param3,param4,param5,param6,this._isColorBlind,this._isShortMode);
         ++this._totalFilledData;
         this.scroll(1);
      }
      
      private function changeContainerVisibility(param1:Boolean) : void
      {
         this._damageLogDetailsImages.visible = param1;
         this._damageLogDetailsText.visible = param1;
      }
      
      private function resetData() : void
      {
         var _loc1_:DamageLogRenderer = null;
         this._nextItemInPoolIdx = 0;
         this._damageLogDetailsImages.y = 0;
         this._damageLogDetailsText.y = 0;
         this._scrollPosition = 0;
         this._totalFilledData = 0;
         for each(_loc1_ in this._poolRenderers)
         {
            changeRendererVisible(_loc1_,false);
         }
      }
      
      private function onDmgLogDetailsImagesMouseWheelHandler(param1:MouseEvent) : void
      {
         if(!this._ctrlButton || this._totalFilledData <= this._visibilityRowsCount)
         {
            return;
         }
         this.scroll(param1.delta);
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
