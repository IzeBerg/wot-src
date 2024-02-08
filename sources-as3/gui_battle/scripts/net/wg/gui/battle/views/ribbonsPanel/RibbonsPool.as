package net.wg.gui.battle.views.ribbonsPanel
{
   import flash.display.DisplayObjectContainer;
   import flash.utils.Dictionary;
   import net.wg.gui.components.ribbon.data.RibbonSettings;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class RibbonsPool implements IDisposable
   {
      
      private static const RIBBON_TYPE_PARAM_IDX:int = 0;
      
      private static const RIBBON_TEXT_PARAM_IDX:int = 1;
       
      
      private var _mapVectorsWithItemsByRibbonType:Dictionary = null;
      
      private var _ribbonsStorage:Vector.<RibbonCtrl> = null;
      
      private var _ribbonsSettings:Dictionary = null;
      
      private var _animationCallback:Function = null;
      
      private var _iconsContainer:DisplayObjectContainer = null;
      
      private var _textsContainer:DisplayObjectContainer = null;
      
      private var _bonusContainer:DisplayObjectContainer = null;
      
      private var _isExtendedAnim:Boolean = false;
      
      private var _isWithRibbonName:Boolean = false;
      
      private var _isWithVehName:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      public function RibbonsPool(param1:DisplayObjectContainer, param2:DisplayObjectContainer, param3:DisplayObjectContainer, param4:Array, param5:Function)
      {
         var _loc7_:Array = null;
         var _loc8_:String = null;
         var _loc9_:RibbonSettings = null;
         var _loc10_:String = null;
         var _loc12_:Vector.<RibbonCtrl> = null;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         super();
         this._iconsContainer = param1;
         this._textsContainer = param2;
         this._bonusContainer = param3;
         this._animationCallback = param5;
         this._ribbonsSettings = new Dictionary();
         this._ribbonsStorage = new Vector.<RibbonCtrl>();
         this._mapVectorsWithItemsByRibbonType = new Dictionary();
         var _loc6_:int = param4.length;
         var _loc11_:int = 0;
         while(_loc11_ < _loc6_)
         {
            _loc7_ = param4[_loc11_];
            _loc8_ = _loc7_[RIBBON_TYPE_PARAM_IDX];
            _loc10_ = _loc7_[RIBBON_TEXT_PARAM_IDX];
            _loc9_ = this.createRibbonSettings(_loc8_,_loc10_);
            this._ribbonsSettings[_loc8_] = _loc9_;
            _loc12_ = new Vector.<RibbonCtrl>(0);
            this._mapVectorsWithItemsByRibbonType[_loc8_] = _loc12_;
            _loc13_ = _loc9_.getStartCountItemsInPool();
            _loc14_ = 0;
            while(_loc14_ < _loc13_)
            {
               _loc12_.push(this.createRibbonCtrl(_loc8_));
               _loc14_++;
            }
            _loc11_++;
         }
      }
      
      public final function dispose() : void
      {
         var _loc1_:RibbonCtrl = null;
         var _loc2_:Vector.<RibbonCtrl> = null;
         this._disposed = true;
         this._iconsContainer = null;
         this._textsContainer = null;
         this._bonusContainer = null;
         this._animationCallback = null;
         App.utils.data.cleanupDynamicObject(this._ribbonsSettings);
         this._ribbonsSettings = null;
         for each(_loc1_ in this._ribbonsStorage)
         {
            _loc1_.dispose();
         }
         for each(_loc2_ in this._mapVectorsWithItemsByRibbonType)
         {
            _loc2_.splice(0,_loc2_.length);
         }
         App.utils.data.cleanupDynamicObject(this._mapVectorsWithItemsByRibbonType);
         this._mapVectorsWithItemsByRibbonType = null;
         this._ribbonsStorage.splice(0,this._ribbonsStorage.length);
         this._ribbonsStorage = null;
      }
      
      public function getItemFromPool(param1:String) : RibbonCtrl
      {
         var _loc3_:RibbonCtrl = null;
         var _loc2_:Vector.<RibbonCtrl> = this._mapVectorsWithItemsByRibbonType[param1];
         if(_loc2_.length == 0)
         {
            _loc3_ = this.createRibbonCtrl(param1);
            _loc3_.setSettings(this._isExtendedAnim,this._isWithRibbonName,this._isWithVehName);
            return _loc3_;
         }
         return _loc2_.shift();
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function returnInPool(param1:RibbonCtrl) : void
      {
         this._mapVectorsWithItemsByRibbonType[param1.ribbonType].push(param1);
      }
      
      public function setSettings(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:RibbonCtrl = null;
         this._isExtendedAnim = param1;
         this._isWithRibbonName = param2;
         this._isWithVehName = param3;
         for each(_loc4_ in this._ribbonsStorage)
         {
            _loc4_.setSettings(param1,param2,param3);
         }
      }
      
      protected function createRibbonSettings(param1:String, param2:String) : RibbonSettings
      {
         return new RibbonSettings(param1,param2);
      }
      
      private function createRibbonCtrl(param1:String) : RibbonCtrl
      {
         var _loc2_:RibbonSettings = this._ribbonsSettings[param1];
         var _loc3_:RibbonCtrl = new RibbonCtrl(_loc2_,this._animationCallback);
         this._iconsContainer.addChildAt(_loc3_.iconsAnim,0);
         this._textsContainer.addChild(_loc3_.textsAnim);
         this._bonusContainer.addChild(_loc3_.bonusAnim);
         this._ribbonsStorage.push(_loc3_);
         return _loc3_;
      }
   }
}
