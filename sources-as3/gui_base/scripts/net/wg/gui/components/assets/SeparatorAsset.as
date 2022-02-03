package net.wg.gui.components.assets
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.assets.data.SeparatorConstants;
   import net.wg.gui.components.assets.interfaces.ISeparatorAsset;
   
   public class SeparatorAsset extends Sprite implements ISeparatorAsset
   {
       
      
      public var fakeImage:Sprite = null;
      
      private var _centerPart:Sprite = null;
      
      private var _leftPart:Sprite = null;
      
      private var _rightPart:Sprite = null;
      
      private var _mode:String = "scaleMode";
      
      private var _actualWidth:Number = 0;
      
      private var _centerPartBitmapData:BitmapData = null;
      
      private var _currentCenterPartLnk:String = "";
      
      private var _tileScaleX:Number = 1;
      
      private var _tileScaleY:Number = 1;
      
      private var _disposed:Boolean = false;
      
      public function SeparatorAsset()
      {
         super();
         var _loc1_:Number = rotation;
         if(_loc1_ != 0)
         {
            rotation = 0;
         }
         this._actualWidth = Math.round(super.width);
         rotation = _loc1_;
         removeChild(this.fakeImage);
         this.fakeImage = null;
         mouseEnabled = mouseChildren = false;
         addEventListener(Event.ADDED_TO_STAGE,this.onAddToStageHandler);
      }
      
      public function clearAssets() : void
      {
         this.deleteParts();
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddToStageHandler);
         this.deleteParts();
      }
      
      override public function get width() : Number
      {
         return this._actualWidth;
      }
      
      override public function set width(param1:Number) : void
      {
         if(this._actualWidth == Math.round(param1))
         {
            return;
         }
         this._actualWidth = Math.round(param1);
         this.draw();
      }
      
      public function setCenterAsset(param1:String) : void
      {
         var _loc4_:Sprite = null;
         var _loc5_:Bitmap = null;
         var _loc6_:Bitmap = null;
         this.deleteCenterPart();
         this._currentCenterPartLnk = param1;
         this._tileScaleX = this._tileScaleY = 1;
         var _loc2_:Class = App.utils.classFactory.getClass(this._currentCenterPartLnk);
         var _loc3_:Object = new _loc2_();
         if(_loc3_ is Sprite)
         {
            _loc4_ = App.utils.classFactory.getComponent(this._currentCenterPartLnk,Sprite);
            if(this._mode == SeparatorConstants.SCALE_MODE)
            {
               this._centerPart = _loc4_;
            }
            else if(this._mode == SeparatorConstants.TILE_MODE)
            {
               _loc5_ = _loc4_.getChildAt(0) as Bitmap;
               this._centerPartBitmapData = _loc5_ != null ? _loc5_.bitmapData : null;
               if(this._centerPartBitmapData)
               {
                  this._tileScaleX = _loc4_.width / this._centerPartBitmapData.width;
                  this._tileScaleY = _loc4_.height / this._centerPartBitmapData.height;
               }
               this._centerPart = new Sprite();
            }
         }
         else if(_loc3_ is BitmapData)
         {
            if(this._mode == SeparatorConstants.SCALE_MODE)
            {
               this._centerPart = new Sprite();
               _loc6_ = new Bitmap(BitmapData(_loc3_));
               this._centerPart.addChild(_loc6_);
            }
            else if(this._mode == SeparatorConstants.TILE_MODE)
            {
               this._centerPartBitmapData = BitmapData(_loc3_);
               this._centerPart = new Sprite();
            }
         }
         else
         {
            App.utils.asserter.assert(false,"Wrong SeparatorAsset center part linkage");
         }
         addChild(this._centerPart);
         this.draw();
      }
      
      public function setMode(param1:String) : void
      {
         App.utils.asserter.assert(SeparatorConstants.MODES.indexOf(param1) != -1,"Unknown SeparatorAsset mode:" + param1);
         if(this._mode == param1)
         {
            return;
         }
         this._mode = param1;
         if(this._currentCenterPartLnk)
         {
            this.setCenterAsset(this._currentCenterPartLnk);
         }
      }
      
      public function setSideAsset(param1:String) : void
      {
         this.deleteSideParts();
         var _loc2_:Class = App.utils.classFactory.getClass(param1);
         var _loc3_:Object = new _loc2_();
         if(_loc3_ is Sprite)
         {
            this._leftPart = App.utils.classFactory.getComponent(param1,Sprite);
            this._rightPart = App.utils.classFactory.getComponent(param1,Sprite);
         }
         else if(_loc3_ is BitmapData)
         {
            this._leftPart = new Sprite();
            this._rightPart = new Sprite();
            this._leftPart.addChild(new Bitmap(BitmapData(_loc3_)));
            this._rightPart.addChild(new Bitmap(BitmapData(_loc3_)));
         }
         else
         {
            App.utils.asserter.assert(false,"Wrong SeparatorAsset side part linkage");
         }
         addChild(this._leftPart);
         addChild(this._rightPart);
         this.draw();
      }
      
      public function setType(param1:String) : void
      {
         App.utils.asserter.assert(SeparatorConstants.TYPES.indexOf(param1) != -1,"Unknown SeparatorAsset type:" + param1);
         this.deleteParts();
         switch(param1)
         {
            case SeparatorConstants.DOTTED_TYPE:
               this.setMode(SeparatorConstants.TILE_MODE);
               this.setSideAsset(Linkages.SEPARATOR_DOTTED_SIDE);
               this.setCenterAsset(Linkages.SEPARATOR_DOTTED_CENTER);
               break;
            case SeparatorConstants.MEDIUM_TYPE:
               this.setMode(SeparatorConstants.SCALE_MODE);
               this.setCenterAsset(Linkages.SEPARATOR_MEDIUM_CENTER);
         }
      }
      
      private function deleteParts() : void
      {
         this.deleteSideParts();
         this.deleteCenterPart();
      }
      
      private function deleteSideParts() : void
      {
         if(this._leftPart)
         {
            while(this._leftPart.numChildren)
            {
               this._leftPart.removeChildAt(0);
            }
            removeChild(this._leftPart);
            this._leftPart = null;
         }
         if(this._rightPart)
         {
            while(this._rightPart.numChildren)
            {
               this._rightPart.removeChildAt(0);
            }
            removeChild(this._rightPart);
            this._rightPart = null;
         }
      }
      
      private function deleteCenterPart() : void
      {
         if(this._centerPart)
         {
            while(this._centerPart.numChildren)
            {
               this._centerPart.removeChildAt(0);
            }
            removeChild(this._centerPart);
            this._centerPart = null;
         }
      }
      
      private function draw() : void
      {
         if(!this._centerPart)
         {
            return;
         }
         var _loc1_:int = this._leftPart != null ? int(Math.round(this._leftPart.width)) : int(0);
         var _loc2_:int = 0;
         if(this._actualWidth < 2 * _loc1_)
         {
            this._actualWidth = 2 * _loc1_;
         }
         if(this._mode == SeparatorConstants.SCALE_MODE)
         {
            this._centerPart.width = this._actualWidth - 2 * _loc1_;
            this._centerPart.x = _loc1_;
         }
         else if(this._mode == SeparatorConstants.TILE_MODE)
         {
            if(!this._centerPartBitmapData)
            {
               return;
            }
            _loc2_ = this._centerPartBitmapData.height;
            this._centerPart.graphics.clear();
            this._centerPart.graphics.beginBitmapFill(this._centerPartBitmapData);
            this._centerPart.graphics.lineTo(0,0);
            this._centerPart.graphics.lineTo((this._actualWidth - 2 * _loc1_) / this._tileScaleX,0);
            this._centerPart.graphics.lineTo((this._actualWidth - 2 * _loc1_) / this._tileScaleX,_loc2_);
            this._centerPart.graphics.lineTo(0,_loc2_);
            this._centerPart.graphics.lineTo(0,0);
            this._centerPart.graphics.endFill();
            this._centerPart.scaleX = this._tileScaleX;
            this._centerPart.scaleY = this._tileScaleY;
            this._centerPart.x = _loc1_;
         }
         if(this._rightPart)
         {
            this._rightPart.rotation = 180;
            this._rightPart.x = this._centerPart.x + Math.round(this._centerPart.width + this._rightPart.width);
            this._rightPart.y = Math.round(this._rightPart.height);
         }
         scaleX = 1;
         scaleY = 1;
      }
      
      public function get actualWidth() : Number
      {
         return this._actualWidth;
      }
      
      private function onAddToStageHandler(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddToStageHandler);
         this.draw();
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
