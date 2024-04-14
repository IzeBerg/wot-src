package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.tradeIn.vo.TradeOffWidgetVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class TradeOffWidgetMeta extends BaseDAAPIComponent
   {
       
      
      public var onClick:Function;
      
      public var onResetClick:Function;
      
      public var getTooltip:Function;
      
      private var _tradeOffWidgetVO:TradeOffWidgetVO;
      
      public function TradeOffWidgetMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._tradeOffWidgetVO)
         {
            this._tradeOffWidgetVO.dispose();
            this._tradeOffWidgetVO = null;
         }
         super.onDispose();
      }
      
      public function onClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onClick,"onClick" + Errors.CANT_NULL);
         this.onClick();
      }
      
      public function onResetClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onResetClick,"onResetClick" + Errors.CANT_NULL);
         this.onResetClick();
      }
      
      public function getTooltipS() : Object
      {
         App.utils.asserter.assertNotNull(this.getTooltip,"getTooltip" + Errors.CANT_NULL);
         return this.getTooltip();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:TradeOffWidgetVO = this._tradeOffWidgetVO;
         this._tradeOffWidgetVO = Boolean(param1) ? new TradeOffWidgetVO(param1) : null;
         this.setData(this._tradeOffWidgetVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:TradeOffWidgetVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
