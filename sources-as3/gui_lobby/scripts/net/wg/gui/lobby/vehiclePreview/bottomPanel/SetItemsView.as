package net.wg.gui.lobby.vehiclePreview.bottomPanel
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.lobby.vehiclePreview.data.VPSetItemVO;
   import net.wg.gui.lobby.vehiclePreview.data.VPSetItemsBlockVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class SetItemsView extends UIComponentEx
   {
      
      public static const BLOCKS_OFFSET:int = 20;
       
      
      public var actualOffset:int = 0;
      
      private var _data:Vector.<VPSetItemsBlockVO>;
      
      private var _blocks:Vector.<SetItemsBlock>;
      
      private var _pluses:Vector.<Bitmap>;
      
      public function SetItemsView()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         visible = false;
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:SetItemsBlock = null;
         var _loc2_:Bitmap = null;
         this._data = null;
         for each(_loc1_ in this._blocks)
         {
            _loc1_.dispose();
         }
         this._blocks.length = 0;
         this._blocks = null;
         for each(_loc2_ in this._pluses)
         {
            _loc2_.bitmapData.dispose();
            _loc2_.bitmapData = null;
         }
         this._pluses.length = 0;
         this._pluses = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._blocks = new Vector.<SetItemsBlock>(0);
         this._pluses = new Vector.<Bitmap>(0);
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:SetItemsBlock = null;
         var _loc3_:Bitmap = null;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:Vector.<VPSetItemVO> = null;
         var _loc8_:VPSetItemsBlockVO = null;
         var _loc9_:int = 0;
         var _loc10_:SetItemsBlock = null;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._data && this._data.length)
            {
               visible = true;
               _loc1_ = 0;
               _loc4_ = this._data.length;
               _loc5_ = this._blocks.length;
               _loc6_ = this._pluses.length;
               _loc9_ = 0;
               while(_loc9_ < _loc4_)
               {
                  _loc7_ = this._data[_loc4_ - _loc9_ - 1].items;
                  if(_loc9_ < _loc5_)
                  {
                     _loc2_ = this._blocks[_loc9_];
                  }
                  else
                  {
                     _loc2_ = this.getNewSetBlock();
                  }
                  _loc8_ = this._data[_loc9_];
                  _loc2_.setData(_loc7_,_loc8_.topTitle,_loc8_.topTitleSmall);
                  _loc2_.enabled = _loc8_.isEnabled;
                  _loc1_ -= _loc2_.width;
                  _loc2_.x = _loc1_;
                  if(_loc9_ < _loc4_ - 1)
                  {
                     if(_loc9_ < _loc6_)
                     {
                        _loc3_ = this._pluses[_loc9_];
                     }
                     else
                     {
                        _loc3_ = this.getNewPlusIcon();
                     }
                     _loc3_.x = _loc1_ - (BLOCKS_OFFSET + _loc3_.width >> 1);
                     _loc3_.y = _loc2_.y + (_loc2_.height - _loc3_.height >> 1);
                  }
                  _loc1_ -= BLOCKS_OFFSET;
                  _loc9_++;
               }
               _loc10_ = this._blocks[0];
               this.actualOffset = _loc10_.actualWidth - _loc10_.width >> 1;
               while(_loc5_-- > _loc4_)
               {
                  _loc2_ = this._blocks.pop();
                  _loc2_.dispose();
                  removeChild(_loc2_);
                  _loc3_ = this._pluses.pop();
                  _loc3_.bitmapData.dispose();
                  _loc3_.bitmapData = null;
                  removeChild(_loc3_);
               }
            }
            else
            {
               visible = false;
            }
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      public function setData(param1:Vector.<VPSetItemsBlockVO>) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      private function getNewSetBlock() : SetItemsBlock
      {
         var _loc1_:SetItemsBlock = null;
         _loc1_ = SetItemsBlock(App.utils.classFactory.getObject(Linkages.SET_ITEMS_BLOCK_UI));
         _loc1_.name = "setBlock_" + this._blocks.push(_loc1_);
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function getNewPlusIcon() : Bitmap
      {
         var _loc1_:Bitmap = new Bitmap(BitmapData(App.utils.classFactory.getObject(Linkages.GREEN_PLUS_ICON)));
         _loc1_.name = "plusIcon_" + this._pluses.push(_loc1_);
         addChild(_loc1_);
         return _loc1_;
      }
   }
}
