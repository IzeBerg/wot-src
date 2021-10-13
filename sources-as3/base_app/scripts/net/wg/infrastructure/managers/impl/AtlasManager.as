package net.wg.infrastructure.managers.impl
{
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.events.EventDispatcher;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Linkages;
   import net.wg.infrastructure.events.AtlasEvent;
   import net.wg.infrastructure.interfaces.IAtlas;
   import net.wg.infrastructure.interfaces.IAtlasItemVO;
   import net.wg.infrastructure.managers.IAtlasManager;
   
   public class AtlasManager extends EventDispatcher implements IAtlasManager
   {
       
      
      private var _atlasesDict:Dictionary = null;
      
      private var _isDisposed:Boolean = false;
      
      private var _lastAtlas:IAtlas = null;
      
      public function AtlasManager()
      {
         super();
         this._atlasesDict = new Dictionary(true);
      }
      
      public function dispose() : void
      {
         var _loc1_:AtlasVO = null;
         App.utils.asserter.assert(!this._isDisposed,"AtlasManager " + Errors.ALREADY_DISPOSED);
         this._isDisposed = true;
         for each(_loc1_ in this._atlasesDict)
         {
            _loc1_.atlas.removeEventListener(AtlasEvent.ATLAS_INITIALIZED,this.onAtlasInitHandler);
            _loc1_.atlas.dispose();
            _loc1_.dispose();
         }
         App.utils.data.cleanupDynamicObject(this._atlasesDict);
         this._atlasesDict = null;
         this._lastAtlas = null;
      }
      
      public function getNewBitmapData(param1:String, param2:String, param3:String = "") : BitmapData
      {
         var _loc4_:IAtlas = this.getAtlas(param1);
         App.utils.asserter.assert(_loc4_ != null && _loc4_.atlasBitmapData != null,"AtlasManager atlas or atlas bitmap \'" + param1 + Errors.CANT_NULL);
         if(_loc4_ == null || _loc4_.atlasBitmapData == null)
         {
            return new BitmapData(1,1);
         }
         var _loc5_:IAtlasItemVO = this.getAtlasItem(_loc4_,param2,param3);
         App.utils.asserter.assertNotNull(_loc5_,"AtlasManager item \'" + _loc5_ + "\' for atlas \'" + param1 + "\'" + Errors.CANT_NULL);
         if(_loc5_ == null)
         {
            return new BitmapData(1,1);
         }
         var _loc6_:BitmapData = new BitmapData(_loc5_.width,_loc5_.height);
         var _loc7_:Rectangle = new Rectangle(_loc5_.x,_loc5_.y,_loc5_.width,_loc5_.height);
         _loc6_.copyPixels(_loc4_.atlasBitmapData,_loc7_,new Point());
         return _loc6_;
      }
      
      public function drawGraphics(param1:String, param2:String, param3:Graphics, param4:String = "", param5:Boolean = false, param6:Boolean = false, param7:Boolean = false) : void
      {
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Matrix = null;
         var _loc8_:IAtlas = this.getAtlas(param1);
         App.utils.asserter.assert(_loc8_ != null && _loc8_.atlasBitmapData != null,"AtlasManager atlas or atlas bitmap \'" + param1 + Errors.CANT_NULL);
         if(_loc8_ == null || _loc8_.atlasBitmapData == null)
         {
            return;
         }
         var _loc9_:IAtlasItemVO = this.getAtlasItem(_loc8_,param2,param4);
         if(_loc9_)
         {
            _loc10_ = 0;
            _loc11_ = 0;
            if(param7)
            {
               _loc10_ = -(_loc9_.width >> 1);
               _loc11_ = -(_loc9_.height >> 1);
            }
            _loc12_ = new Matrix();
            _loc12_.translate(-_loc9_.x + _loc10_,-_loc9_.y + _loc11_);
            param3.clear();
            param3.beginBitmapFill(_loc8_.atlasBitmapData,_loc12_,param6,param5);
            param3.drawRect(_loc10_,_loc11_,_loc9_.width,_loc9_.height);
            param3.endFill();
         }
         else
         {
            DebugUtils.LOG_ERROR("AtlasManager can\'t find item \'" + param2 + "\' (altName: \'" + param4 + "\' ) in atlas \'" + param1 + "\'");
            param3.clear();
            param3.beginFill(16711680,0.5);
            param3.drawRect(0,0,10,10);
            param3.endFill();
         }
      }
      
      private function getAtlasItem(param1:IAtlas, param2:String, param3:String) : IAtlasItemVO
      {
         var _loc4_:IAtlasItemVO = param1.getAtlasItemVOByName(param2);
         if(!_loc4_ && param3 != "")
         {
            _loc4_ = param1.getAtlasItemVOByName(param3);
         }
         return _loc4_;
      }
      
      public function isAtlasInitialized(param1:String) : Boolean
      {
         var _loc2_:IAtlas = this.getAtlas(param1);
         return _loc2_ != null && _loc2_.isAtlasInitialized;
      }
      
      public function registerAtlas(param1:String, param2:Object = null) : void
      {
         var _loc3_:IAtlas = this.getAtlas(param1);
         if(_loc3_)
         {
            if(param2)
            {
               this._atlasesDict[param1].locks.push(param2);
            }
            return;
         }
         var _loc4_:Class = App.utils.classFactory.getClass(Linkages.ATLAS_CLASS_NAME);
         _loc3_ = new _loc4_();
         _loc3_.initResources(param1);
         _loc3_.addEventListener(AtlasEvent.ATLAS_INITIALIZED,this.onAtlasInitHandler);
         var _loc5_:AtlasVO = new AtlasVO(_loc3_);
         if(param2)
         {
            _loc5_.locks.push(param2);
         }
         this._atlasesDict[param1] = _loc5_;
         this._lastAtlas = _loc3_;
      }
      
      public function unregisterAtlas(param1:String, param2:Object) : void
      {
         var _loc3_:AtlasVO = this._atlasesDict[param1];
         var _loc4_:int = _loc3_.locks.indexOf(param2);
         if(_loc4_ != -1)
         {
            _loc3_.locks.splice(_loc4_,1);
            if(_loc3_.locks.length == 0)
            {
               if(this._lastAtlas == _loc3_.atlas)
               {
                  this._lastAtlas = null;
               }
               _loc3_.atlas.removeEventListener(AtlasEvent.ATLAS_INITIALIZED,this.onAtlasInitHandler);
               _loc3_.atlas.dispose();
               _loc3_.dispose();
               delete this._atlasesDict[param1];
            }
         }
      }
      
      public function waitForAtlasInit(param1:String, param2:Function) : void
      {
         var _loc3_:IAtlas = this.getAtlas(param1);
         if(_loc3_ && _loc3_.isAtlasInitialized)
         {
            param2();
         }
         else
         {
            this.registerAtlas(param1);
            this._atlasesDict[_loc3_.atlasName].pendingInitialization.push(param2);
         }
      }
      
      public function forgetAtlas(param1:String, param2:Function) : void
      {
         var _loc4_:int = 0;
         var _loc3_:Vector.<Function> = this._atlasesDict[param1].pendingInitialization;
         if(_loc3_)
         {
            _loc4_ = _loc3_.indexOf(param2);
            if(_loc4_ != -1)
            {
               _loc3_.splice(_loc4_,1);
            }
         }
      }
      
      private function getAtlas(param1:String) : IAtlas
      {
         if(this._lastAtlas && this._lastAtlas.atlasName == param1)
         {
            return this._lastAtlas;
         }
         var _loc2_:AtlasVO = this._atlasesDict[param1];
         this._lastAtlas = Boolean(_loc2_) ? _loc2_.atlas : null;
         return this._lastAtlas;
      }
      
      private function onAtlasInitHandler(param1:AtlasEvent) : void
      {
         var _loc4_:Function = null;
         var _loc2_:IAtlas = param1.currentTarget as IAtlas;
         _loc2_.removeEventListener(AtlasEvent.ATLAS_INITIALIZED,this.onAtlasInitHandler);
         var _loc3_:AtlasVO = this._atlasesDict[_loc2_.atlasName];
         for each(_loc4_ in _loc3_.pendingInitialization)
         {
            _loc4_();
         }
         _loc3_.pendingInitialization.length = 0;
      }
   }
}

import net.wg.infrastructure.interfaces.IAtlas;
import net.wg.infrastructure.interfaces.entity.IDisposable;

class AtlasVO implements IDisposable
{
    
   
   public var atlas:IAtlas;
   
   public var locks:Array;
   
   public var pendingInitialization:Vector.<Function>;
   
   function AtlasVO(param1:IAtlas)
   {
      this.locks = [];
      this.pendingInitialization = new Vector.<Function>(0);
      super();
      this.atlas = param1;
   }
   
   public function dispose() : void
   {
      this.atlas = null;
      this.locks.length = 0;
      this.locks = null;
      this.pendingInitialization.length = 0;
      this.pendingInitialization = null;
   }
}
