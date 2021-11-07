package net.wg.gui.lobby.settings
{
   import net.wg.gui.components.controls.BorderShadowScrollPane;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class AdvancedGraphicSettingsForm extends UIComponentEx
   {
      
      private static const PANE_WIDTH:Number = 800;
      
      private static const PANE_HEIGHT:Number = 410;
       
      
      public var scrollPane:BorderShadowScrollPane;
      
      public function AdvancedGraphicSettingsForm()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.scrollPane.setSize(PANE_WIDTH,PANE_HEIGHT);
         var _loc1_:AdvancedGraphicContentForm = this.scrollPane.target as AdvancedGraphicContentForm;
         App.utils.asserter.assertNotNull(_loc1_,"scrollPane.target must be AdvancedGraphicContentForm");
      }
      
      override protected function onDispose() : void
      {
         this.scrollPane.dispose();
         this.scrollPane = null;
         super.onDispose();
      }
   }
}
