package net.wg.gui.lobby.components
{
   import net.wg.data.constants.Values;
   import net.wg.gui.components.advanced.interfaces.ICooldownSlot;
   import net.wg.gui.components.controls.VO.SlotVO;
   import net.wg.gui.components.controls.slotsPanel.impl.BaseSlotsPanel;
   import net.wg.gui.lobby.components.data.BoosterSlotVO;
   import net.wg.gui.lobby.components.events.BoosterPanelEvent;
   import net.wg.gui.lobby.components.interfaces.IBoosterSlot;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class BoostersPanel extends BaseSlotsPanel
   {
      
      private static const ALL_GROUP:int = 0;
       
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function BoostersPanel()
      {
         this._toolTipMgr = App.toolTipMgr;
         super(ALL_GROUP);
      }
      
      private static function isLinkageEquals(param1:ICooldownSlot, param2:SlotVO) : Boolean
      {
         var _loc3_:BoosterSlotVO = BoosterSlotVO(param1.data);
         var _loc4_:BoosterSlotVO = BoosterSlotVO(param2);
         return _loc3_.slotLinkage == _loc4_.slotLinkage;
      }
      
      override protected function setSlots(param1:Vector.<SlotVO>) : void
      {
         super.setSlots(param1);
         invalidate(InvalidationType.RENDERERS);
      }
      
      override protected function updateSlot(param1:SlotVO) : void
      {
         super.updateSlot(param1);
         invalidate(InvalidationType.RENDERERS);
      }
      
      override protected function onDispose() : void
      {
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      override protected function setSlotData(param1:ICooldownSlot, param2:SlotVO) : void
      {
         super.setSlotData(param1,param2);
         var _loc3_:IUpdatable = IUpdatable(param1);
         _loc3_.update(param2);
      }
      
      override protected function setupSlot(param1:ICooldownSlot, param2:SlotVO) : void
      {
         super.setupSlot(param1,param2);
         if(!param2.isInactive)
         {
            param1.addEventListener(ButtonEvent.CLICK,this.onSlotClickHandler);
         }
      }
      
      override protected function cleanUpSlot(param1:ICooldownSlot) : void
      {
         super.cleanUpSlot(param1);
         param1.removeEventListener(ButtonEvent.CLICK,this.onSlotClickHandler);
      }
      
      override protected function getSlotVOOfItemForOrders(param1:Object) : SlotVO
      {
         return new BoosterSlotVO(param1);
      }
      
      override protected function createSlot(param1:SlotVO) : ICooldownSlot
      {
         var _loc2_:BoosterSlotVO = BoosterSlotVO(param1);
         return App.utils.classFactory.getComponent(_loc2_.slotLinkage,BaseBoosterSlot);
      }
      
      override protected function canUpdate(param1:ICooldownSlot, param2:SlotVO) : Boolean
      {
         return super.canUpdate(param1,param2) && isLinkageEquals(param1,param2);
      }
      
      override protected function removeNotNeeded(param1:ICooldownSlot, param2:SlotVO) : Boolean
      {
         return param1.id == param2.id && isLinkageEquals(param1,param2);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.RENDERERS))
         {
            drawSlots();
         }
      }
      
      override protected function layoutSlots() : void
      {
         var _loc4_:BaseBoosterSlot = null;
         var _loc5_:int = 0;
         var _loc6_:BaseBoosterSlot = null;
         var _loc1_:Vector.<BaseBoosterSlot> = Vector.<BaseBoosterSlot>(slots);
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         for each(_loc4_ in _loc1_)
         {
            if(_loc4_.width > _loc2_)
            {
               _loc2_ = _loc4_.width;
            }
            if(_loc4_.itemsOffset > _loc3_)
            {
               _loc3_ = _loc4_.itemsOffset;
            }
         }
         for each(_loc4_ in _loc1_)
         {
            if(_loc4_.itemsOffset < _loc3_)
            {
               _loc4_.itemsOffset = _loc3_;
            }
            if(_loc4_.width < _loc2_)
            {
               _loc4_.width = _loc2_;
            }
         }
         super.layoutSlots();
         _loc5_ = Boolean(_loc1_) ? int(_loc1_.length) : int(Values.ZERO);
         if(_loc5_ != Values.ZERO)
         {
            _loc6_ = _loc1_[_loc1_.length - 1];
            setSize(_loc6_.x + _loc6_.width,_loc6_.y + _loc6_.height);
         }
      }
      
      override protected function getSlotsOffset() : int
      {
         return 0;
      }
      
      override protected function showSlotTooltip(param1:ICooldownSlot) : void
      {
         var _loc2_:Number = IBoosterSlot(param1).boosterId;
         if(StringUtils.isNotEmpty(tooltip))
         {
            if(_loc2_ != Values.DEFAULT_INT)
            {
               this._toolTipMgr.showSpecial(tooltip,null,_loc2_);
            }
            else
            {
               this._toolTipMgr.showComplex(tooltip);
            }
         }
      }
      
      private function onSlotClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:BaseBoosterSlot = BaseBoosterSlot(param1.currentTarget);
         var _loc3_:BoosterSlotVO = BoosterSlotVO(_loc2_.data);
         dispatchEvent(new BoosterPanelEvent(BoosterPanelEvent.SLOT_SELECTED,_loc3_));
      }
   }
}
