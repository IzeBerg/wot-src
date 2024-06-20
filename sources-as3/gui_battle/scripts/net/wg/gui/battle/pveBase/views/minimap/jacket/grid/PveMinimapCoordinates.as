package net.wg.gui.battle.pveBase.views.minimap.jacket.grid
{
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class PveMinimapCoordinates extends BattleUIComponent
   {
      
      public static const THICKNESS:int = 16;
       
      
      public var item1:BattleAtlasSprite;
      
      public var item2:BattleAtlasSprite;
      
      public var item3:BattleAtlasSprite;
      
      public var item4:BattleAtlasSprite;
      
      public var item5:BattleAtlasSprite;
      
      public var item6:BattleAtlasSprite;
      
      public var item7:BattleAtlasSprite;
      
      public var item8:BattleAtlasSprite;
      
      public var item9:BattleAtlasSprite;
      
      public var item10:BattleAtlasSprite;
      
      protected var _scrollRect:Rectangle;
      
      protected var _sprites:Vector.<BattleAtlasSprite>;
      
      public function PveMinimapCoordinates()
      {
         var _loc1_:BattleAtlasSprite = null;
         this._scrollRect = new Rectangle(0,0,THICKNESS,THICKNESS);
         super();
         this._sprites = new <BattleAtlasSprite>[this.item1,this.item2,this.item3,this.item4,this.item5,this.item6,this.item7,this.item8,this.item9,this.item10];
         for each(_loc1_ in this._sprites)
         {
            _loc1_.visible = false;
            _loc1_.isCentralize = true;
         }
      }
      
      protected function hideAllSprites() : void
      {
         var _loc1_:BattleAtlasSprite = null;
         for each(_loc1_ in this._sprites)
         {
            _loc1_.visible = false;
         }
      }
      
      override protected function onDispose() : void
      {
         this._sprites.length = 0;
         this._sprites = null;
         this.item1 = null;
         this.item2 = null;
         this.item3 = null;
         this.item4 = null;
         this.item5 = null;
         this.item6 = null;
         this.item7 = null;
         this.item8 = null;
         this.item9 = null;
         this.item10 = null;
         super.onDispose();
      }
      
      public function applyRectangle(param1:Rectangle) : void
      {
         scrollRect = this._scrollRect;
      }
      
      public function redraw(param1:int, param2:int) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc6_:DisplayObject = null;
         cacheAsBitmap = false;
         this.hideAllSprites();
         _loc3_ = param1 / param2;
         _loc4_ = _loc3_ / 2;
         var _loc5_:int = 0;
         while(_loc5_ < param2)
         {
            _loc6_ = this._sprites[_loc5_];
            _loc6_.visible = true;
            this.placeSymbol(_loc6_,_loc5_ * _loc3_ + _loc4_);
            _loc5_++;
         }
         cacheAsBitmap = true;
      }
      
      protected function placeSymbol(param1:DisplayObject, param2:int) : void
      {
      }
   }
}
