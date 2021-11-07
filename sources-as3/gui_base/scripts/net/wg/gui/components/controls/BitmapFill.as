package net.wg.gui.components.controls
{
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class BitmapFill extends UIComponentEx
   {
      
      public static const FILL_COLOR:int = 13762560;
      
      public static const REPEAT_NONE:String = "none";
      
      public static const REPEAT_HORIZONTAL:String = "horizontal";
      
      public static const REPEAT_VERTICAL:String = "vertical";
      
      public static const REPEAT_ALL:String = "all";
      
      public static const START_POS_TOP_LEFT:String = "TL";
      
      public static const START_POS_TOP_RIGHT:String = "TR";
      
      public static const START_POS_TOP_CENTER:String = "TC";
      
      public static const START_POS_BOTTOM_LEFT:String = "BL";
      
      public static const START_POS_BOTTOM_RIGHT:String = "BR";
      
      public static const START_POS_BOTTOM_CENTER:String = "BC";
      
      public static const START_POS_MIDDLE_LEFT:String = "CL";
      
      public static const START_POS_MIDDLE_RIGHT:String = "CR";
      
      public static const START_POS_CENTER:String = "CC";
       
      
      public var tempBg:MovieClip = null;
      
      public var pos:Rectangle = null;
      
      [Inspectable(defaultValue="none",enumeration="none,horizontal,vertical,all",verbose="1")]
      public var repeat:String = "none";
      
      [Inspectable(defaultValue="TL",enumeration="TL,TR,TC,BL,BR,BC,CL,CR,CC",verbose="1")]
      public var startPos:String = "TL";
      
      private var _bitmapData:BitmapData = null;
      
      private var _src:String = "";
      
      private var _needDispose:Boolean = false;
      
      private var _matrix:Matrix = null;
      
      public function BitmapFill()
      {
         super();
         if(!this.pos)
         {
            this.createPos();
            this.pos.x = 0;
            this.pos.y = 0;
            this.pos.width = this.tempBg.width * this.scaleX;
            this.pos.height = this.tempBg.height * this.scaleY;
         }
         if(this.tempBg)
         {
            this.tempBg.visible = false;
         }
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         this.createPos();
         this.pos.width = param1;
         this.pos.height = param2;
         invalidateData();
      }
      
      override protected function onDispose() : void
      {
         this.disposeBitmapData();
         this.tempBg = null;
         this.pos = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._matrix = new Matrix();
      }
      
      override protected function draw() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         super.draw();
         this.graphics.clear();
         if(this._bitmapData != null && isInvalid(InvalidationType.DATA))
         {
            this.graphics.beginFill(FILL_COLOR);
            this.graphics.beginBitmapFill(this._bitmapData,this._matrix);
            _loc1_ = this.pos.x;
            _loc2_ = this.pos.y;
            _loc3_ = this.pos.width;
            _loc4_ = this.pos.height;
            switch(this.repeat)
            {
               case REPEAT_NONE:
                  _loc3_ = this._bitmapData.width;
                  _loc4_ = this._bitmapData.height;
                  break;
               case REPEAT_HORIZONTAL:
                  _loc3_ = this.pos.width;
                  _loc4_ = this._bitmapData.height;
                  break;
               case REPEAT_VERTICAL:
                  _loc3_ = this._bitmapData.width;
                  _loc4_ = this.pos.height;
                  break;
               case REPEAT_ALL:
                  _loc3_ = this.pos.width;
                  _loc4_ = this.pos.height;
            }
            switch(this.startPos)
            {
               case START_POS_TOP_LEFT:
                  _loc1_ = 0;
                  _loc2_ = 0;
                  break;
               case START_POS_TOP_RIGHT:
                  _loc1_ = -_loc3_;
                  _loc2_ = 0;
                  break;
               case START_POS_TOP_CENTER:
                  _loc1_ = -(_loc3_ >> 1);
                  _loc2_ = 0;
                  break;
               case START_POS_BOTTOM_LEFT:
                  _loc1_ = 0;
                  _loc2_ = -_loc4_;
                  break;
               case START_POS_BOTTOM_RIGHT:
                  _loc1_ = -_loc3_;
                  _loc2_ = -_loc4_;
                  break;
               case START_POS_BOTTOM_CENTER:
                  _loc1_ = -(_loc3_ >> 1);
                  _loc2_ = -_loc4_;
                  break;
               case START_POS_MIDDLE_LEFT:
                  _loc1_ = 0;
                  _loc2_ = -(_loc4_ >> 1);
                  break;
               case START_POS_MIDDLE_RIGHT:
                  _loc1_ = -_loc3_;
                  _loc2_ = -(_loc4_ >> 1);
                  break;
               case START_POS_CENTER:
                  _loc1_ = -(_loc3_ >> 1);
                  _loc2_ = -(_loc4_ >> 1);
            }
            this.graphics.lineTo(_loc1_,_loc2_);
            this.graphics.lineTo(_loc1_ + _loc3_,_loc2_);
            this.graphics.lineTo(_loc1_ + _loc3_,_loc2_ + _loc4_);
            this.graphics.lineTo(_loc1_,_loc2_ + _loc4_);
            this.graphics.lineTo(_loc1_,_loc2_);
            this.graphics.endFill();
         }
      }
      
      public function getBitmap() : BitmapData
      {
         return this._bitmapData;
      }
      
      public function setBitmap(param1:BitmapData, param2:Boolean = false) : void
      {
         this._bitmapData = param1;
         this._needDispose = param2;
         invalidate();
      }
      
      private function disposeBitmapData() : void
      {
         if(this._needDispose && this._bitmapData)
         {
            this._bitmapData.dispose();
         }
         this._bitmapData = null;
         this._needDispose = false;
      }
      
      private function createPos() : void
      {
         if(!this.pos)
         {
            this.pos = new Rectangle();
         }
      }
      
      [Inspectable(defaultValue="",name="source")]
      public function get source() : String
      {
         return this._src;
      }
      
      public function set source(param1:String) : void
      {
         var _loc2_:Class = null;
         this.disposeBitmapData();
         this._src = param1;
         if(this._src != "")
         {
            _loc2_ = App.utils.classFactory.getClass(this._src);
            this._bitmapData = BitmapData(new _loc2_());
            this._needDispose = true;
            invalidate();
         }
      }
      
      public function get widthFill() : Number
      {
         return this.pos.width;
      }
      
      [Inspectable(defaultValue="100",name="widthFill",type="Number")]
      public function set widthFill(param1:Number) : void
      {
         this.setSize(param1,this.pos.height);
      }
      
      public function get heightFill() : Number
      {
         return this.pos.height;
      }
      
      [Inspectable(defaultValue="100",name="heightFill",type="Number")]
      public function set heightFill(param1:Number) : void
      {
         this.setSize(this.pos.width,param1);
      }
      
      public function set matrix(param1:Matrix) : void
      {
         this._matrix = param1;
      }
      
      public function get matrix() : Matrix
      {
         return this._matrix;
      }
   }
}
