package net.wg.gui.battle.views.personalReservesTab
{
   import flash.display.DisplayObject;
   import net.wg.infrastructure.base.meta.IPersonalReservesTabMeta;
   import net.wg.infrastructure.base.meta.impl.PersonalReservesTabMeta;
   import net.wg.infrastructure.interfaces.entity.IDisplayableComponent;
   
   public class PersonalReservesTab extends PersonalReservesTabMeta implements IPersonalReservesTabMeta, IDisplayableComponent
   {
      
      private static const WIDTH:int = 920;
      
      private static const HEIGHT:int = 594;
       
      
      public function PersonalReservesTab()
      {
         super();
         setSize(WIDTH,HEIGHT);
      }
      
      override public function addChild(param1:DisplayObject) : DisplayObject
      {
         var _loc2_:DisplayObject = super.addChild(param1);
         if(wrapper)
         {
            wrapper.visible = visible;
         }
         return _loc2_;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(visible != param1)
         {
            super.visible = param1;
            if(wrapper)
            {
               wrapper.visible = param1;
            }
         }
      }
      
      public function setCompVisible(param1:Boolean) : void
      {
      }
      
      public function isCompVisible() : Boolean
      {
         return visible;
      }
   }
}
