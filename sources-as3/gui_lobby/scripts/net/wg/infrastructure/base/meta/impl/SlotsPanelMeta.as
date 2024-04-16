package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.controls.VO.SlotVO;
   import net.wg.gui.components.controls.VO.SlotsPanelPropsVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class SlotsPanelMeta extends BaseDAAPIComponent
   {
       
      
      public var getSlotTooltipBody:Function;
      
      private var _slotsPanelPropsVO:SlotsPanelPropsVO;
      
      private var _vectorSlotVO:Vector.<SlotVO>;
      
      public function SlotsPanelMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:SlotVO = null;
         if(this._slotsPanelPropsVO)
         {
            this._slotsPanelPropsVO.dispose();
            this._slotsPanelPropsVO = null;
         }
         if(this._vectorSlotVO)
         {
            for each(_loc1_ in this._vectorSlotVO)
            {
               _loc1_.dispose();
            }
            this._vectorSlotVO.splice(0,this._vectorSlotVO.length);
            this._vectorSlotVO = null;
         }
         super.onDispose();
      }
      
      public function getSlotTooltipBodyS(param1:String) : String
      {
         App.utils.asserter.assertNotNull(this.getSlotTooltipBody,"getSlotTooltipBody" + Errors.CANT_NULL);
         return this.getSlotTooltipBody(param1);
      }
      
      public final function as_setPanelProps(param1:Object) : void
      {
         var _loc2_:SlotsPanelPropsVO = this._slotsPanelPropsVO;
         this._slotsPanelPropsVO = new SlotsPanelPropsVO(param1);
         this.setPanelProps(this._slotsPanelPropsVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setSlots(param1:Array) : void
      {
         var _loc5_:SlotVO = null;
         var _loc2_:Vector.<SlotVO> = this._vectorSlotVO;
         this._vectorSlotVO = new Vector.<SlotVO>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorSlotVO[_loc4_] = this.getSlotVOOfItemForOrders(param1[_loc4_]);
            _loc4_++;
         }
         this.setSlots(this._vectorSlotVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      public final function as_updateSlot(param1:Object) : void
      {
         var _loc2_:SlotVO = this.getSlotVOForData(param1);
         this.updateSlot(_loc2_);
      }
      
      protected function setPanelProps(param1:SlotsPanelPropsVO) : void
      {
         var _loc2_:String = "as_setPanelProps" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function getSlotVOOfItemForOrders(param1:Object) : SlotVO
      {
         var _loc2_:String = "getSlotVOOfItemForOrders" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setSlots(param1:Vector.<SlotVO>) : void
      {
         var _loc2_:String = "as_setSlots" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function getSlotVOForData(param1:Object) : SlotVO
      {
         var _loc2_:String = "getSlotVOForData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function updateSlot(param1:SlotVO) : void
      {
         var _loc2_:String = "as_updateSlot" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
