package net.wg.gui.battle.commander.views.commanderHelp
{
   import flash.display.MovieClip;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.commander.VO.daapi.DAAPIHelpVO;
   import net.wg.gui.battle.components.buttons.interfaces.IClickButtonHandler;
   import net.wg.infrastructure.base.meta.ICommanderHelpMeta;
   import net.wg.infrastructure.base.meta.impl.CommanderHelpMeta;
   
   public class CommanderHelp extends CommanderHelpMeta implements ICommanderHelpMeta, IClickButtonHandler
   {
      
      private static const LEFT_START_POS:int = -213;
      
      private static const GROUP_OFFSET:int = 99;
      
      private static const IN_GROUP_OFFSET:int = 57;
      
      private static const IN_GROUP_MODIFIER_OFFSET:int = 69;
      
      private static const TOP_BUTTON_OFFSET:int = 8;
      
      private static const INVALIDATE_DRAW_LAYOUT:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const INVALIDATE_POSITION:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
      
      private static const PANEL_FIRST_SPACE_POS:int = 2;
      
      private static const PANEL_SECOND_SPACE_POS:int = 5;
       
      
      public var bg:MovieClip = null;
      
      private var _ordersList:Vector.<CommanderHelpItem>;
      
      public function CommanderHelp()
      {
         this._ordersList = new Vector.<CommanderHelpItem>();
         super();
         this.bg.mouseEnabled = false;
      }
      
      override protected function onDispose() : void
      {
         this.removeAllItems();
         this._ordersList = null;
         this.bg = null;
         super.onDispose();
      }
      
      override protected function setOrderItems(param1:Vector.<DAAPIHelpVO>) : void
      {
         var _loc2_:DAAPIHelpVO = null;
         var _loc3_:CommanderHelpItem = null;
         this.removeAllItems();
         for each(_loc2_ in param1)
         {
            _loc3_ = App.utils.classFactory.getComponent(_loc2_.rendererLinkage,CommanderHelpItem);
            _loc3_.setData(_loc2_);
            _loc3_.isTooltipSpecial = true;
            _loc3_.addClickCallBack(this);
            addChildAt(_loc3_,1);
            this._ordersList.push(_loc3_);
         }
         invalidate(INVALIDATE_DRAW_LAYOUT);
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:CommanderHelpItem = null;
         super.draw();
         if(isInvalid(INVALIDATE_DRAW_LAYOUT))
         {
            _loc1_ = LEFT_START_POS;
            _loc2_ = 0;
            for each(_loc3_ in this._ordersList)
            {
               _loc3_.x = _loc1_;
               _loc3_.y = TOP_BUTTON_OFFSET;
               _loc2_++;
               if(_loc2_ == PANEL_FIRST_SPACE_POS || _loc2_ == PANEL_SECOND_SPACE_POS)
               {
                  _loc1_ += GROUP_OFFSET;
               }
               else if(_loc3_.getHelpVO().isModifier)
               {
                  _loc1_ += IN_GROUP_MODIFIER_OFFSET;
               }
               else
               {
                  _loc1_ += IN_GROUP_OFFSET;
               }
            }
            invalidate(INVALIDATE_POSITION);
         }
      }
      
      public function as_updateOrderState(param1:int, param2:Boolean, param3:Boolean, param4:Boolean) : void
      {
         if(0 > param1 || param1 >= this._ordersList.length)
         {
            return;
         }
         this._ordersList[param1].updateButtonState(param2,param3,param4);
         this._ordersList[param1].enabled = !param4;
      }
      
      public function onButtonClick(param1:Object) : void
      {
         var _loc2_:CommanderHelpItem = param1 as CommanderHelpItem;
         if(_loc2_.isDisabled())
         {
            return;
         }
         onOrderButtonClickedS(param1.getHelpVO().keyID);
      }
      
      private function removeAllItems() : void
      {
         var _loc1_:CommanderHelpItem = null;
         for each(_loc1_ in this._ordersList)
         {
            removeChild(_loc1_);
            _loc1_.dispose();
         }
         this._ordersList.length = 0;
      }
   }
}
