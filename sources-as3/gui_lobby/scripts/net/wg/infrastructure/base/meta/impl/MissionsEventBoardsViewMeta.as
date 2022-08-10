package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.missions.MissionsListViewBase;
   
   public class MissionsEventBoardsViewMeta extends MissionsListViewBase
   {
       
      
      public var openBoardView:Function;
      
      public var participateClick:Function;
      
      public var orderClick:Function;
      
      public var techniqueClick:Function;
      
      public var awardClick:Function;
      
      public var registrationClick:Function;
      
      public var serverClick:Function;
      
      public var expand:Function;
      
      public function MissionsEventBoardsViewMeta()
      {
         super();
      }
      
      public function openBoardViewS() : void
      {
         App.utils.asserter.assertNotNull(this.openBoardView,"openBoardView" + Errors.CANT_NULL);
         this.openBoardView();
      }
      
      public function participateClickS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.participateClick,"participateClick" + Errors.CANT_NULL);
         this.participateClick(param1);
      }
      
      public function orderClickS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.orderClick,"orderClick" + Errors.CANT_NULL);
         this.orderClick(param1);
      }
      
      public function techniqueClickS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.techniqueClick,"techniqueClick" + Errors.CANT_NULL);
         this.techniqueClick(param1);
      }
      
      public function awardClickS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.awardClick,"awardClick" + Errors.CANT_NULL);
         this.awardClick(param1);
      }
      
      public function registrationClickS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.registrationClick,"registrationClick" + Errors.CANT_NULL);
         this.registrationClick(param1);
      }
      
      public function serverClickS(param1:String, param2:String) : void
      {
         App.utils.asserter.assertNotNull(this.serverClick,"serverClick" + Errors.CANT_NULL);
         this.serverClick(param1,param2);
      }
      
      public function expandS(param1:String, param2:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.expand,"expand" + Errors.CANT_NULL);
         this.expand(param1,param2);
      }
   }
}
