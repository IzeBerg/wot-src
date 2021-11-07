package net.wg.gui.components.tooltips.inblocks.blocks
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.tooltips.inblocks.interfaces.IPoolTooltipBlock;
   import net.wg.infrastructure.events.PoolItemEvent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BaseTooltipBlock extends Sprite implements IPoolTooltipBlock
   {
       
      
      private var _isInvalid:Boolean = false;
      
      private var _isInPool:Boolean = false;
      
      public function BaseTooltipBlock()
      {
         super();
      }
      
      public function cleanUp() : void
      {
      }
      
      public final function dispose() : void
      {
         if(this.isInPool)
         {
            dispatchEvent(new PoolItemEvent(PoolItemEvent.ITEM_TURN_OUT,this));
         }
         else
         {
            this.onDispose();
         }
      }
      
      public function getBg() : DisplayObject
      {
         return null;
      }
      
      public function getDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function getWidth() : Number
      {
         return width;
      }
      
      public function getHeight() : Number
      {
         return height;
      }
      
      public function getStretchBg() : Boolean
      {
         return false;
      }
      
      public function isBlockInvalid() : Boolean
      {
         return this._isInvalid;
      }
      
      public function setBlockData(param1:Object) : void
      {
         throw new AbstractException("BaseTooltipBlock.setBlockData" + Errors.ABSTRACT_INVOKE);
      }
      
      public function setBlockWidth(param1:int) : void
      {
         throw new AbstractException("BaseTooltipBlock.setBlockWidth" + Errors.ABSTRACT_INVOKE);
      }
      
      public final function tryValidateBlock() : void
      {
         this._isInvalid = this.onValidateBlock();
      }
      
      protected final function invalidateBlock() : void
      {
         this._isInvalid = true;
         this.onInvalidateBlock();
      }
      
      protected function onValidateBlock() : Boolean
      {
         return false;
      }
      
      protected function onInvalidateBlock() : void
      {
      }
      
      protected function onDispose() : void
      {
      }
      
      public function get isInPool() : Boolean
      {
         return this._isInPool;
      }
      
      public function set isInPool(param1:Boolean) : void
      {
         this._isInPool = param1;
      }
   }
}
