package net.wg.gui.lobby.hangar.eventEntryPoint
{
   import flash.geom.Rectangle;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.containers.inject.GFInjectComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.constants.InvalidationType;
   
   public class EventEntryPointBase extends GFInjectComponent implements IEventEntryPoint
   {
       
      
      private var _size:int;
      
      public function EventEntryPointBase()
      {
         this._size = EntryPointSize.SMALL;
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateSize();
         }
      }
      
      protected function updateSize() : void
      {
         throw new AbstractException("updateSize" + Errors.ABSTRACT_INVOKE);
      }
      
      public function get size() : int
      {
         return this._size;
      }
      
      public function set size(param1:int) : void
      {
         if(this._size != param1)
         {
            this._size = param1;
            invalidateSize();
         }
      }
      
      public function get margin() : Rectangle
      {
         return new Rectangle(0,0,0,0);
      }
   }
}
