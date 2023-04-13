package net.wg.gui.components.hintPanel
{
   import flash.display.BlendMode;
   import flash.display.Sprite;
   import flash.utils.getDefinitionByName;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class KeyViewersList extends Sprite implements IDisposable
   {
      
      private static const DEFAULT_KEY_GAP:int = 35;
      
      private static const PLUS_SIZE:int = 8;
       
      
      private var _keys:Vector.<KeyViewer>;
      
      private var _pluses:Vector.<Image>;
      
      private var _keyClass:Class = null;
      
      private var _keyGap:int = 35;
      
      private var _keySideOffset:int;
      
      private var _disposed:Boolean = false;
      
      public function KeyViewersList()
      {
         this._keys = new Vector.<KeyViewer>(0);
         this._pluses = new Vector.<Image>(0);
         this._keySideOffset = KeyViewer.DEFAULT_KEY_SIDE_OFFSET;
         super();
         this._keyClass = getDefinitionByName(Linkages.KEY_VIEWER) as Class;
      }
      
      public function clearKeys() : void
      {
         var _loc1_:KeyViewer = null;
         var _loc2_:Image = null;
         for each(_loc1_ in this._keys)
         {
            removeChild(_loc1_);
            _loc1_.dispose();
            _loc1_ = null;
         }
         this._keys.splice(0,this._keys.length);
         for each(_loc2_ in this._pluses)
         {
            removeChild(_loc2_);
            _loc2_.dispose();
            _loc2_ = null;
         }
         this._pluses.splice(0,this._pluses.length);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.clearKeys();
         this._keys = null;
         this._pluses = null;
         this._keyClass = null;
      }
      
      public function setKeys(param1:Array, param2:Array) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:KeyViewer = null;
         var _loc10_:Image = null;
         this.clearKeys();
         var _loc3_:int = param2.length;
         if(_loc3_ > 0)
         {
            _loc4_ = 0;
            _loc5_ = true;
            _loc6_ = 0;
            while(_loc6_ < _loc3_)
            {
               _loc7_ = param2[_loc6_];
               _loc8_ = param1[_loc6_];
               _loc9_ = new this._keyClass();
               _loc9_.keySideOffset = this._keySideOffset;
               _loc9_.setKey(_loc8_,_loc7_);
               _loc9_.x = _loc4_ >> 0;
               _loc4_ += _loc9_.width + this._keyGap;
               if(!_loc5_)
               {
                  _loc10_ = new Image();
                  _loc10_.source = RES_ICONS.MAPS_ICONS_LIBRARY_HINT_PLUS;
                  _loc10_.x = _loc9_.x - (this._keyGap + PLUS_SIZE >> 1);
                  _loc10_.y = _loc9_.height - PLUS_SIZE >> 1;
                  this._pluses.push(_loc10_);
                  addChild(_loc10_);
               }
               _loc5_ = false;
               this._keys.push(_loc9_);
               addChild(_loc9_);
               _loc6_++;
            }
            cacheAsBitmap = true;
            blendMode = BlendMode.SCREEN;
         }
      }
      
      public function set keyClass(param1:Class) : void
      {
         if(param1 != null)
         {
            this._keyClass = param1;
         }
      }
      
      public function set keyGap(param1:int) : void
      {
         this._keyGap = param1;
      }
      
      public function set keySideOffset(param1:int) : void
      {
         this._keySideOffset = param1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
