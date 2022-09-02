package net.wg.infrastructure.tutorial.helpBtnControllers
{
   import flash.display.Stage;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.AbstractWindowView;
   
   public class TutorialWindowHelpBtnCtrllr extends TutorialHelpBtnController
   {
      
      private static const HELP_BTN_X_OFFSET:int = 2;
       
      
      public function TutorialWindowHelpBtnCtrllr()
      {
         super();
      }
      
      override public function layoutHelpBtn() : void
      {
         var _loc1_:AbstractWindowView = view as AbstractWindowView;
         App.utils.asserter.assertNotNull(_loc1_,"view as AbstractWindowView" + Errors.CANT_NULL);
         var _loc2_:Stage = App.stage;
         var _loc3_:Number = App.appScale;
         var _loc4_:Rectangle = _loc1_.window.getBtnsBounds();
         var _loc5_:Point = _loc2_.localToGlobal(new Point(_loc4_.x,_loc4_.y));
         var _loc6_:Point = _loc2_.localToGlobal(new Point(view.x,view.y));
         helpBtn.x = (_loc5_.x - _loc6_.x) / _loc3_ - helpBtn.width - HELP_BTN_X_OFFSET ^ 0;
         helpBtn.y = (_loc5_.y - _loc6_.y) / _loc3_ ^ 0;
      }
   }
}
