package net.wg.gui.battle.views.minimap.components.entries.battleRoyale
{
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.data.constants.generated.BATTLE_ROYAL_CONSTS;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.infrastructure.managers.IAtlasManager;
   import scaleform.clik.motion.Tween;
   
   public class DeathZoneMinimapEntry extends BattleUIComponent
   {
      
      private static const ROW_SHIFT:int = 0;
      
      private static const COLUMN_SHIFT:int = 1;
      
      private static const STATE_SHIFT:int = 2;
      
      private static const PARAMS_NUM:int = 3;
      
      private static const DEATHZONE_ANIM_DURATION:int = 500;
      
      private static const MAX_ROW_COUNT:int = 100;
       
      
      private var _deathZoneDict:Dictionary = null;
      
      private var _deathZonePool:Vector.<Sprite> = null;
      
      private var _cellSize:int = -1;
      
      private var _showTween:Tween = null;
      
      private var _hideTween:Tween = null;
      
      private var _showContainer:Sprite = null;
      
      private var _hideContainer:Sprite = null;
      
      private var _atlasMgr:IAtlasManager;
      
      public function DeathZoneMinimapEntry()
      {
         this._atlasMgr = App.atlasMgr;
         super();
         this._deathZoneDict = new Dictionary(true);
         this._deathZonePool = new Vector.<Sprite>(0);
         this._hideContainer = new Sprite();
         addChild(this._hideContainer);
         this._showContainer = new Sprite();
         addChild(this._showContainer);
         this._showTween = new Tween(DEATHZONE_ANIM_DURATION,this._showContainer,{"alpha":1},{
            "paused":true,
            "onComplete":this.showAnimComplete
         });
         this._hideTween = new Tween(DEATHZONE_ANIM_DURATION,this._hideContainer,{"alpha":0},{
            "paused":true,
            "onComplete":this.hideAnimComplete
         });
      }
      
      private static function getDeathZoneKey(param1:int, param2:int) : int
      {
         return param1 * MAX_ROW_COUNT + param2;
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:DisplayObject = null;
         var _loc2_:DisplayObject = null;
         for each(_loc1_ in this._deathZoneDict)
         {
            removeChild(_loc1_);
         }
         App.utils.data.cleanupDynamicObject(this._deathZoneDict);
         this._deathZoneDict = null;
         for each(_loc2_ in this._deathZonePool)
         {
            removeChild(_loc2_);
         }
         this._deathZonePool.splice(0,this._deathZonePool.length);
         this._deathZonePool = null;
         this._showTween.dispose();
         this._showTween = null;
         this._hideTween.dispose();
         this._hideTween = null;
         this._showContainer = null;
         this._hideContainer = null;
         this._atlasMgr = null;
         super.onDispose();
      }
      
      public function as_initDeathZoneSize(param1:Number) : void
      {
         this._cellSize = param1;
      }
      
      public function as_updateDeathZones(... rest) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Sprite = null;
         var _loc7_:int = 0;
         App.utils.asserter.assertNotNull(rest,"Args" + Errors.CANT_NULL);
         var _loc2_:int = rest.length;
         App.utils.asserter.assert(_loc2_ % PARAMS_NUM == 0,"Wrong number of arguments");
         this._hideContainer.alpha = 1;
         this._showContainer.alpha = 0;
         var _loc8_:int = 0;
         while(_loc8_ < _loc2_)
         {
            _loc3_ = rest[_loc8_ + ROW_SHIFT];
            _loc4_ = rest[_loc8_ + COLUMN_SHIFT];
            _loc5_ = rest[_loc8_ + STATE_SHIFT];
            _loc7_ = getDeathZoneKey(_loc3_,_loc4_);
            _loc6_ = this._deathZoneDict[_loc7_];
            if(_loc6_ != null)
            {
               this._hideContainer.addChild(_loc6_);
            }
            switch(_loc5_)
            {
               case BATTLE_ROYAL_CONSTS.DEATH_ZONE_STATE_WARNING:
                  _loc6_ = this._deathZonePool.shift();
                  if(!_loc6_)
                  {
                     _loc6_ = new Sprite();
                     _loc6_.blendMode = BlendMode.ADD;
                  }
                  this._atlasMgr.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,BATTLEATLAS.DEATHZONE_WARNING,_loc6_.graphics);
                  break;
               case BATTLE_ROYAL_CONSTS.DEATH_ZONE_STATE_CLOSED:
                  _loc6_ = new Sprite();
                  this._atlasMgr.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,BATTLEATLAS.DEATHZONE_CLOSED,_loc6_.graphics);
                  break;
               default:
                  App.utils.asserter.assert(false,Errors.WRONG_VALUE + " state = " + _loc5_);
                  _loc8_ += PARAMS_NUM;
                  continue;
            }
            this._deathZoneDict[_loc7_] = _loc6_;
            this._showContainer.addChild(_loc6_);
            this.updateDeathZone(_loc6_,_loc3_,_loc4_);
            _loc8_ += PARAMS_NUM;
         }
         this._hideTween.reset();
         this._hideTween.paused = false;
         this._showTween.reset();
         this._showTween.paused = false;
      }
      
      private function showAnimComplete(param1:Tween) : void
      {
         var _loc2_:int = this._showContainer.numChildren;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            addChild(this._showContainer.getChildAt(0));
            _loc3_++;
         }
      }
      
      private function updateDeathZone(param1:Sprite, param2:int, param3:int) : void
      {
         param1.x = param2 * this._cellSize;
         param1.y = param3 * this._cellSize;
         param1.width = param1.height = this._cellSize;
      }
      
      private function hideAnimComplete(param1:Tween) : void
      {
         var _loc3_:DisplayObject = null;
         var _loc2_:int = this._hideContainer.numChildren;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = this._hideContainer.removeChildAt(0);
            this._deathZonePool.push(DisplayObject(_loc3_));
            _loc4_++;
         }
      }
   }
}
