package net.wg.gui.battle.random.views.teamBasesPanel
{
   import flash.events.Event;
   import flash.utils.Dictionary;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.base.meta.ITeamBasesPanelMeta;
   import net.wg.infrastructure.base.meta.impl.TeamBasesPanelMeta;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   import scaleform.clik.motion.Tween;
   
   public class TeamBasesPanel extends TeamBasesPanelMeta implements ITeamBasesPanelMeta
   {
      
      private static const RENDERER_HEIGHT:Number = 34;
      
      private static const ASSERT_MSG:String = "[TeamBasesPanel] Can\'t find teamCaptureBar with id=";
      
      private static const DEF_MAX_BARS_COUNT:uint = 0;
      
      private static const ALPHA_FADE_SPEED:Number = 500;
      
      private static const FULL_ALPHA:Number = 1;
       
      
      private var _captureBars:Vector.<TeamCaptureBar> = null;
      
      private var _cachedBars:Vector.<TeamCaptureBar> = null;
      
      private var _capturedBarsIndexesById:Dictionary = null;
      
      private var _needBarOffset:Boolean = false;
      
      private var _colorSchemeMgr:IColorSchemeManager;
      
      private var _dataIsCleared:Boolean = false;
      
      private var _fadeOutTweens:Dictionary = null;
      
      private var _panelHeight:int = 0;
      
      public function TeamBasesPanel()
      {
         this._colorSchemeMgr = App.colorSchemeMgr;
         super();
         this._captureBars = new Vector.<TeamCaptureBar>();
         this._cachedBars = new Vector.<TeamCaptureBar>();
         var _loc1_:uint = 0;
         while(_loc1_ < DEF_MAX_BARS_COUNT)
         {
            this.createBar();
            _loc1_++;
         }
         this._fadeOutTweens = new Dictionary();
      }
      
      private static function sortBarsFn(param1:TeamCaptureBar, param2:TeamCaptureBar) : Number
      {
         var _loc3_:Number = param1.sortWeight;
         var _loc4_:Number = param2.sortWeight;
         return _loc3_ < _loc4_ ? Number(-1) : (_loc3_ > _loc4_ ? Number(1) : Number(0));
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemeMgrSchemasUpdatedHandler);
      }
      
      override protected function onDispose() : void
      {
         this._colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemeMgrSchemasUpdatedHandler);
         this._colorSchemeMgr = null;
         this.disposeItemsAndData();
         super.onDispose();
      }
      
      public function as_add(param1:Number, param2:Number, param3:String, param4:String, param5:Number, param6:String, param7:String) : void
      {
         var _loc8_:TeamCaptureBar = null;
         var _loc9_:TeamCaptureBar = null;
         if(this._fadeOutTweens[param1])
         {
            this.removeFadeOutTween(param1);
            _loc9_ = this.getCaptureBarById(param1);
            _loc9_.alpha = FULL_ALPHA;
            return;
         }
         if(this._capturedBarsIndexesById && this._capturedBarsIndexesById[param1])
         {
            return;
         }
         if(this._cachedBars.length == 0)
         {
            this.createBar();
         }
         _loc8_ = this._cachedBars.pop();
         addChild(_loc8_);
         _loc8_.setData(param1,param2,param3,param4,param5,param6,param7);
         this._captureBars.push(_loc8_);
         this._captureBars.sort(sortBarsFn);
         this.updateBuildIndexByIDCache();
         this.updatePositions();
         _loc8_.visible = true;
         _loc8_.alpha = 1;
      }
      
      public function as_clear() : void
      {
         this._dataIsCleared = true;
         this.cleanItemsAndData();
      }
      
      public function as_remove(param1:Number) : void
      {
         var id:Number = param1;
         var index:uint = this._capturedBarsIndexesById[id];
         var teamCaptureBar:TeamCaptureBar = this._captureBars[index];
         var fadeoutTween:Tween = new Tween(ALPHA_FADE_SPEED,teamCaptureBar,{"alpha":0},{
            "delay":ALPHA_FADE_SPEED,
            "onComplete":function(param1:Tween):void
            {
               if(!isDisposed())
               {
                  removeBar(id);
                  param1.dispose();
                  removeFadeOutTween(id);
               }
            }
         });
         this._fadeOutTweens[id] = fadeoutTween;
      }
      
      public function as_setCaptured(param1:Number, param2:String) : void
      {
         if(!this._dataIsCleared)
         {
            this.getCaptureBarById(param1).setCaptured(param2);
         }
      }
      
      public function as_setOffsetForEnemyPoints() : void
      {
         this._needBarOffset = true;
      }
      
      public function as_stopCapture(param1:Number, param2:Number) : void
      {
         if(!this._dataIsCleared)
         {
            this.getCaptureBarById(param1).stopCapture(param2);
         }
      }
      
      public function as_updateCaptureData(param1:Number, param2:Number, param3:Number, param4:String, param5:String, param6:String, param7:String) : void
      {
         if(!this._dataIsCleared)
         {
            this.getCaptureBarById(param1).updateCaptureData(param2,true,false,param3,param4,param5,param6,param7);
         }
      }
      
      protected function setBarYPosition(param1:uint, param2:int) : void
      {
         var _loc3_:TeamCaptureBar = this._captureBars[param1];
         if(_loc3_ != null)
         {
            _loc3_.y = param2;
         }
      }
      
      private function updateColors() : void
      {
         var _loc1_:uint = this._captureBars.length;
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_)
         {
            this._captureBars[_loc2_].updateColors();
            _loc2_++;
         }
      }
      
      private function removeBar(param1:Number) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TeamCaptureBar = null;
         if(this._capturedBarsIndexesById)
         {
            _loc2_ = this._capturedBarsIndexesById[param1];
            _loc3_ = this._captureBars.splice(_loc2_,1)[0];
            removeChild(_loc3_);
            this._cachedBars.push(_loc3_);
            this.updateBuildIndexByIDCache();
            this.updatePositions();
         }
      }
      
      private function removeFadeOutTween(param1:Number) : void
      {
         var _loc2_:Tween = this._fadeOutTweens[param1];
         _loc2_.onComplete = null;
         _loc2_.onChange = null;
         _loc2_.paused = true;
         _loc2_.dispose();
         delete this._fadeOutTweens[param1];
      }
      
      private function cleanCapturedBarsIndexes() : void
      {
         App.utils.data.cleanupDynamicObject(this._capturedBarsIndexesById);
         this._capturedBarsIndexesById = null;
      }
      
      private function disposeItemsAndData() : void
      {
         var _loc1_:Tween = null;
         this.cleanCapturedBarsIndexes();
         while(this._captureBars.length)
         {
            this.disposeBar(this._captureBars.pop(),true);
         }
         this._captureBars = null;
         while(this._cachedBars.length)
         {
            this.disposeBar(this._cachedBars.pop(),false);
         }
         this._cachedBars = null;
         for each(_loc1_ in this._fadeOutTweens)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         App.utils.data.cleanupDynamicObject(this._fadeOutTweens);
         this._fadeOutTweens = null;
      }
      
      private function cleanItemsAndData() : void
      {
         this.cleanCapturedBarsIndexes();
         var _loc1_:TeamCaptureBar = null;
         while(this._captureBars.length)
         {
            _loc1_ = this._captureBars.pop();
            removeChild(_loc1_);
            this._cachedBars.push(_loc1_);
         }
      }
      
      private function disposeBar(param1:TeamCaptureBar, param2:Boolean) : void
      {
         param1.dispose();
         if(param2)
         {
            removeChild(param1);
         }
      }
      
      private function updateBuildIndexByIDCache() : void
      {
         var _loc1_:uint = this._captureBars.length;
         this.cleanCapturedBarsIndexes();
         this._capturedBarsIndexesById = new Dictionary();
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_)
         {
            this._capturedBarsIndexesById[this._captureBars[_loc2_].id] = _loc2_;
            _loc2_++;
         }
      }
      
      private function updatePositions() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:uint = 0;
         var _loc1_:uint = this._captureBars.length;
         this._panelHeight = Values.ZERO;
         if(_loc1_ > 0)
         {
            _loc2_ = this._needBarOffset && this._captureBars[0].colorType == TeamCaptureFeel.COLOR_TYPE_RED ? Number(RENDERER_HEIGHT) : Number(0);
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               this.setBarYPosition(_loc3_,_loc2_);
               _loc3_++;
               _loc2_ += RENDERER_HEIGHT;
            }
            this._panelHeight = _loc2_;
         }
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      private function getCaptureBarById(param1:Number) : TeamCaptureBar
      {
         var _loc3_:int = 0;
         var _loc2_:TeamCaptureBar = null;
         if(param1 in this._capturedBarsIndexesById)
         {
            _loc3_ = this._capturedBarsIndexesById[param1];
            _loc2_ = this._captureBars[_loc3_];
         }
         else
         {
            App.utils.asserter.assert(false,ASSERT_MSG + param1);
         }
         App.utils.asserter.assertNotNull(_loc2_,ASSERT_MSG + param1);
         return _loc2_;
      }
      
      protected function getBarLinkage() : String
      {
         return Linkages.CAPTURE_BAR_LINKAGE;
      }
      
      private function createBar() : void
      {
         var _loc1_:TeamCaptureBar = App.utils.classFactory.getComponent(this.getBarLinkage(),TeamCaptureBar);
         _loc1_.visible = false;
         _loc1_.x = 0;
         this._cachedBars.push(_loc1_);
      }
      
      public function get panelHeight() : int
      {
         return this._panelHeight;
      }
      
      private function onColorSchemeMgrSchemasUpdatedHandler(param1:ColorSchemeEvent) : void
      {
         this.updateColors();
      }
   }
}
