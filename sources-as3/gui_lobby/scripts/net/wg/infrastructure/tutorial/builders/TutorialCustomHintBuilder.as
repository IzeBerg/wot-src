package net.wg.infrastructure.tutorial.builders
{
   import flash.display.MovieClip;
   import flash.geom.Point;
   import net.wg.gui.components.controls.ContentTabRenderer;
   import net.wg.gui.lobby.header.headerButtonBar.HeaderButton;
   import net.wg.gui.lobby.techtree.nodes.NationTreeNode;
   import net.wg.gui.lobby.techtree.nodes.ResearchRoot;
   
   public class TutorialCustomHintBuilder extends TutorialHintBuilder
   {
      
      private static const NATION_TREE_ADD_X:int = 164;
      
      private static const NATION_TREE_ADD_Y:int = -106;
      
      private static const NATION_TREE_ADD_WIDTH:int = 38;
      
      private static const NATION_TREE_ADD_HEIGHT:int = 71;
       
      
      public function TutorialCustomHintBuilder()
      {
         super();
      }
      
      override protected function layoutHint() : void
      {
         var _loc3_:int = 0;
         var _loc6_:HeaderButton = null;
         var _loc7_:MovieClip = null;
         var _loc8_:ContentTabRenderer = null;
         var _loc1_:Point = new Point();
         var _loc2_:int = 0;
         _loc3_ = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(component is HeaderButton)
         {
            _loc6_ = HeaderButton(component);
            _loc1_ = component.localToGlobal(new Point(0,0));
            _loc1_ = view.globalToLocal(_loc1_);
            _loc4_ = _loc6_.bounds.width;
            _loc5_ = component.height;
         }
         else if(component is ResearchRoot)
         {
            _loc7_ = ResearchRoot(component).hit;
            _loc1_ = _loc7_.localToGlobal(new Point(0,0));
            _loc1_ = view.globalToLocal(_loc1_);
            _loc4_ = _loc7_.width;
            _loc5_ = _loc7_.height;
         }
         else if(component is NationTreeNode)
         {
            _loc7_ = NationTreeNode(component).hit;
            _loc2_ = NATION_TREE_ADD_X;
            _loc3_ = -model.padding.top + NATION_TREE_ADD_Y;
            _loc4_ = _loc7_.width + NATION_TREE_ADD_WIDTH;
            _loc5_ = _loc7_.height + NATION_TREE_ADD_HEIGHT;
            _loc1_ = _loc7_.localToGlobal(new Point(0,0));
            _loc1_ = view.globalToLocal(new Point(_loc1_.x,view.height - _loc5_ >> 1));
         }
         else if(component is ContentTabRenderer)
         {
            _loc8_ = ContentTabRenderer(component);
            _loc1_ = _loc8_.owner.localToGlobal(new Point(0,0));
            _loc1_ = view.globalToLocal(_loc1_);
            _loc2_ = _loc8_.owner.width >> 1;
            _loc4_ = _loc8_.width;
            _loc5_ = _loc8_.height;
         }
         hint.x = _loc1_.x - HINT_GLOW_OFFSET + model.padding.left + _loc2_ ^ 0;
         hint.y = _loc1_.y - HINT_GLOW_OFFSET + model.padding.top + _loc3_ ^ 0;
         hint.setSize(_loc4_ - model.padding.left - model.padding.right,_loc5_ - model.padding.top - model.padding.bottom);
      }
   }
}
