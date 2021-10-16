package net.wg.mock.utils
{
   import net.wg.utils.helpLayout.IHelpLayout;
   import net.wg.utils.helpLayout.IHelpLayoutComponent;
   
   public class MockHelpLayout implements IHelpLayout
   {
       
      
      public function MockHelpLayout()
      {
         super();
      }
      
      public function dispose() : void
      {
      }
      
      public function hide() : void
      {
      }
      
      public function isShown() : Boolean
      {
         return false;
      }
      
      public function registerComponent(param1:IHelpLayoutComponent) : void
      {
      }
      
      public function show() : void
      {
      }
      
      public function unregisterComponent(param1:IHelpLayoutComponent) : void
      {
      }
   }
}
