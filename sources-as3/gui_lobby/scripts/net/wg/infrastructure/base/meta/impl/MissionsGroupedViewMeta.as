package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.missions.MissionsListViewBase;
   
   public class MissionsGroupedViewMeta extends MissionsListViewBase
   {
       
      
      public var expand:Function;
      
      public var clickActionBtn:Function;
      
      public var onClickButtonDetails:Function;
      
      public function MissionsGroupedViewMeta()
      {
         super();
      }
      
      public function expandS(param1:String, param2:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.expand,"expand" + Errors.CANT_NULL);
         this.expand(param1,param2);
      }
      
      public function clickActionBtnS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.clickActionBtn,"clickActionBtn" + Errors.CANT_NULL);
         this.clickActionBtn(param1);
      }
      
      public function onClickButtonDetailsS() : void
      {
         App.utils.asserter.assertNotNull(this.onClickButtonDetails,"onClickButtonDetails" + Errors.CANT_NULL);
         this.onClickButtonDetails();
      }
   }
}
