package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.battleRoyale.widget.data.BattleRoyaleHangarWidgetVO;
   import net.wg.gui.lobby.hangar.quests.HangarWidgetDAAPI;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BattleRoyaleHangarWidgetMeta extends HangarWidgetDAAPI
   {
       
      
      public var onClick:Function;
      
      public var onChangeServerClick:Function;
      
      private var _battleRoyaleHangarWidgetVO:BattleRoyaleHangarWidgetVO;
      
      public function BattleRoyaleHangarWidgetMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._battleRoyaleHangarWidgetVO)
         {
            this._battleRoyaleHangarWidgetVO.dispose();
            this._battleRoyaleHangarWidgetVO = null;
         }
         super.onDispose();
      }
      
      public function onClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onClick,"onClick" + Errors.CANT_NULL);
         this.onClick();
      }
      
      public function onChangeServerClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onChangeServerClick,"onChangeServerClick" + Errors.CANT_NULL);
         this.onChangeServerClick();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:BattleRoyaleHangarWidgetVO = this._battleRoyaleHangarWidgetVO;
         this._battleRoyaleHangarWidgetVO = new BattleRoyaleHangarWidgetVO(param1);
         this.setData(this._battleRoyaleHangarWidgetVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:BattleRoyaleHangarWidgetVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
