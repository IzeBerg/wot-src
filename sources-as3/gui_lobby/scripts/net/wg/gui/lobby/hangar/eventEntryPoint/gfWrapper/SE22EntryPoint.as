package net.wg.gui.lobby.hangar.eventEntryPoint.gfWrapper
{
   import flash.geom.Rectangle;
   import flash.text.TextFormatAlign;
   import net.wg.gui.lobby.hangar.eventEntryPoint.EntryPointSize;
   import net.wg.infrastructure.base.meta.ISE22EntryPointMeta;
   import net.wg.infrastructure.base.meta.impl.SE22EntryPointMeta;
   import net.wg.infrastructure.managers.counter.CounterManager;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICounterManager;
   
   public class SE22EntryPoint extends SE22EntryPointMeta implements ISE22EntryPointMeta
   {
      
      private static const INV_COUNTER:String = "InvCounter";
      
      private static const COUNTER_SMALL:CounterProps = new CounterProps(0,0);
      
      private static const COUNTER_BIG:CounterProps = new CounterProps(-2,6,TextFormatAlign.RIGHT,true,CounterProps.DEFAULT_LINKAGE,18);
      
      private static const MARGIN:Rectangle = new Rectangle(0,-1,-1,0);
       
      
      private var _counterManager:ICounterManager;
      
      private var _isNew:Boolean;
      
      public function SE22EntryPoint()
      {
         this._counterManager = App.utils.counterManager;
         super();
      }
      
      override protected function updateSize() : void
      {
         super.updateSize();
         invalidate(INV_COUNTER);
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         var _loc2_:CounterProps = null;
         super.draw();
         if(isInvalid(INV_COUNTER))
         {
            this._counterManager.removeCounter(this);
            if(this._isNew)
            {
               if(EntryPointSize.isWide(size) || EntryPointSize.isBig(size))
               {
                  _loc1_ = MENU.COUNTER_NEWCOUNTER;
                  _loc2_ = COUNTER_BIG;
               }
               else
               {
                  _loc1_ = CounterManager.EXCLAMATION_COUNTER_VALUE;
                  _loc2_ = COUNTER_SMALL;
               }
               this._counterManager.setCounter(this,_loc1_,null,_loc2_);
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this._counterManager.removeCounter(this);
         this._counterManager = null;
         super.onDispose();
      }
      
      public function setIsNew(param1:Boolean) : void
      {
         if(this._isNew != param1)
         {
            this._isNew = param1;
            invalidate(INV_COUNTER);
         }
      }
      
      override public function get margin() : Rectangle
      {
         return MARGIN;
      }
   }
}
