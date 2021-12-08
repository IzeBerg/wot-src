package net.wg.gui.lobby.storage.categories.cards.configs
{
   import flash.geom.Rectangle;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class CardSizeVO implements IDisposable
   {
       
      
      public var size:Rectangle;
      
      public var innerPadding:Rectangle;
      
      public var outerPadding:int;
      
      public var descriptionOffset:int;
      
      public var flagsOffset:int;
      
      public function CardSizeVO(param1:Rectangle, param2:Rectangle, param3:int, param4:int, param5:int)
      {
         super();
         this.size = param1;
         this.innerPadding = param2;
         this.outerPadding = param3;
         this.descriptionOffset = param4;
         this.flagsOffset = param5;
      }
      
      public function dispose() : void
      {
         this.size = null;
         this.innerPadding = null;
      }
   }
}
