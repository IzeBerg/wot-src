package net.wg.gui.utils
{
   import flash.display.Graphics;
   import flash.events.EventDispatcher;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import net.wg.gui.components.containers.Atlas;
   import net.wg.infrastructure.events.AtlasEvent;
   import net.wg.infrastructure.interfaces.IAtlas;
   import net.wg.infrastructure.interfaces.IAtlasItemVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class RootSWFAtlasManager extends EventDispatcher implements IDisposable
   {
      
      private static var _instance:RootSWFAtlasManager;
       
      
      private var _itemsToDraw:Vector.<AtlasItemData> = null;
      
      private var _atlasMap:Object;
      
      private var _disposed:Boolean = false;
      
      public function RootSWFAtlasManager()
      {
         this._atlasMap = {};
         super();
      }
      
      public static function get instance() : RootSWFAtlasManager
      {
         if(!_instance)
         {
            _instance = new RootSWFAtlasManager();
         }
         return _instance;
      }
      
      public function dispose() : void
      {
         var _loc2_:* = null;
         var _loc3_:IAtlas = null;
         this._disposed = true;
         var _loc1_:Array = [];
         for(_loc2_ in this._atlasMap)
         {
            _loc1_.push(_loc2_);
         }
         for each(_loc2_ in _loc1_)
         {
            _loc3_ = this._atlasMap[_loc2_];
            _loc3_.removeEventListener(AtlasEvent.ATLAS_INITIALIZED,this.onAtlasInitializedHandler);
            _loc3_.dispose();
            delete this._atlasMap[_loc2_];
         }
         this._atlasMap = null;
         if(this._itemsToDraw)
         {
            while(this._itemsToDraw.length)
            {
               this._itemsToDraw.shift().dispose();
            }
            this._itemsToDraw = null;
         }
         _instance = null;
      }
      
      public function drawGraphics(param1:String, param2:String, param3:Graphics, param4:Point = null) : void
      {
         var _loc6_:IAtlasItemVO = null;
         var _loc7_:Matrix = null;
         var _loc5_:IAtlas = this.getAtlas(param1);
         if(_loc5_.isAtlasInitialized)
         {
            _loc6_ = _loc5_.getAtlasItemVOByName(param2);
            if(_loc6_)
            {
               _loc7_ = new Matrix();
               if(!param4)
               {
                  param4 = new Point(0,0);
               }
               _loc7_.translate(-_loc6_.x + param4.x,-_loc6_.y + param4.y);
               param3.clear();
               param3.beginBitmapFill(_loc5_.atlasBitmapData,_loc7_,false,true);
               param3.drawRect(param4.x,param4.y,_loc6_.width,_loc6_.height);
               param3.endFill();
            }
         }
         else
         {
            if(!this._itemsToDraw)
            {
               this._itemsToDraw = new Vector.<AtlasItemData>();
            }
            this._itemsToDraw.push(new AtlasItemData(param1,param2,param3,param4,false,false));
         }
      }
      
      public function drawWithCenterAlign(param1:String, param2:String, param3:Graphics, param4:Boolean, param5:Boolean, param6:int = 0, param7:int = 0) : void
      {
         var _loc9_:IAtlasItemVO = null;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc8_:IAtlas = this.getAtlas(param1);
         if(_loc8_.isAtlasInitialized)
         {
            _loc9_ = _loc8_.getAtlasItemVOByName(param2);
            if(_loc9_)
            {
               _loc10_ = !!param4 ? Number(-_loc9_.width >> 1) : Number(param6);
               _loc11_ = !!param5 ? Number(-_loc9_.height >> 1) : Number(param7);
               this.drawGraphics(param1,param2,param3,new Point(_loc10_,_loc11_));
            }
         }
         else
         {
            if(!this._itemsToDraw)
            {
               this._itemsToDraw = new Vector.<AtlasItemData>();
            }
            this._itemsToDraw.push(new AtlasItemData(param1,param2,param3,new Point(param6,param7),param4,param5));
         }
      }
      
      public function getAtlasItemBounds(param1:String, param2:String) : Rectangle
      {
         var _loc3_:IAtlasItemVO = this.getAtlas(param1).getAtlasItemVOByName(param2);
         return Boolean(_loc3_) ? new Rectangle(_loc3_.x,_loc3_.y,_loc3_.width,_loc3_.height) : null;
      }
      
      public function initAtlas(param1:String) : void
      {
         if(App.instance != null && this._atlasMap[param1])
         {
            App.utils.asserter.assert(false,"Atlas already " + param1 + " inited");
         }
         var _loc2_:IAtlas = this.getAtlas(param1);
         this._atlasMap[param1] = _loc2_;
         _loc2_.addEventListener(AtlasEvent.ATLAS_INITIALIZED,this.onAtlasInitializedHandler);
         _loc2_.initResources(param1);
      }
      
      public function isAtlasInitialized(param1:String) : Boolean
      {
         var _loc2_:IAtlas = this.getAtlas(param1);
         return _loc2_.isAtlasInitialized;
      }
      
      private function getAtlas(param1:String) : IAtlas
      {
         var _loc2_:IAtlas = this._atlasMap[param1];
         if(_loc2_ == null)
         {
            _loc2_ = new Atlas();
         }
         return _loc2_;
      }
      
      private function onAtlasInitializedHandler(param1:AtlasEvent) : void
      {
         var _loc2_:AtlasItemData = null;
         if(this._itemsToDraw)
         {
            while(this._itemsToDraw.length)
            {
               _loc2_ = this._itemsToDraw.shift();
               if(_loc2_.centerHorizontally || _loc2_.centerHorizontally)
               {
                  this.drawWithCenterAlign(_loc2_.atlasName,_loc2_.name,_loc2_.graphics,_loc2_.centerHorizontally,_loc2_.centerVertically,_loc2_.position.x,_loc2_.position.y);
               }
               else
               {
                  this.drawGraphics(_loc2_.atlasName,_loc2_.name,_loc2_.graphics,_loc2_.position);
               }
            }
            this._itemsToDraw = null;
         }
         IAtlas(param1.currentTarget).removeEventListener(AtlasEvent.ATLAS_INITIALIZED,this.onAtlasInitializedHandler);
         dispatchEvent(new AtlasEvent(AtlasEvent.ATLAS_INITIALIZED));
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}

import flash.display.Graphics;
import flash.geom.Point;
import net.wg.infrastructure.interfaces.entity.IDisposable;

class AtlasItemData implements IDisposable
{
    
   
   public var name:String = null;
   
   public var atlasName:String = null;
   
   public var graphics:Graphics = null;
   
   public var position:Point = null;
   
   public var centerHorizontally:Boolean = false;
   
   public var centerVertically:Boolean = false;
   
   private var _disposed:Boolean = false;
   
   function AtlasItemData(param1:String, param2:String, param3:Graphics, param4:Point, param5:Boolean, param6:Boolean)
   {
      super();
      this.name = param2;
      this.atlasName = param1;
      this.graphics = param3;
      this.position = param4;
      this.centerHorizontally = param5;
      this.centerVertically = param6;
   }
   
   public final function dispose() : void
   {
      this._disposed = true;
      this.name = null;
      this.graphics = null;
      this.position = null;
   }
   
   public function isDisposed() : Boolean
   {
      return this._disposed;
   }
}
